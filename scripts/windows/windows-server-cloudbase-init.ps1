#download installer
#$client = new-object System.Net.WebClient
#$client.DownloadFile("https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi", "C:\Windows\temp\CloudbaseInitSetup_Stable_x64.msi" )

$CloudbaseFileName = "CloudbaseInitSetup_Stable_x64.msi"

add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

Invoke-WebRequest -Uri "https://cloudbase.it/downloads/$CloudbaseFileName" -OutFile "C:\Windows\temp\$CloudbaseFileName" -UseBasicParsing


# install the payload
Start-process -FilePath "C:\Windows\temp\$CloudbaseFileName" -ArgumentList '/qn /l*v C:\windows\temp\cloud-init.log LOGGINGSERIALPORTNAME=COM1 USERNAME=Administrator' -passthru | wait-process

# verify that cloudbase-init tools exists
if (-not(test-path -path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\")) {                                                                                                                                              
  Write-output "cloudbase-init not installed exiting..."
  exit 1
}   

#Move-Item C:\Windows\Temp\cloudbase-init-unattend.conf "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" -force
#Move-Item C:\Windows\Temp\cloudbase-init.conf "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -force
#Move-Item C:\Windows\Temp\cloudbase-init-firstboot.ps1 "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts\cloudbase-init-firstboot.ps1" -force
Start-Process -NoNewWindow -FilePath "C:/Windows/system32/sc.exe" -ArgumentList "config cloudbase-init start=demand" -Wait

#cloudbase-init-unattend.conf
$CloudbaseInitUnattendContents = @"
[DEFAULT]
username=Administrator
groups=Administrators
inject_user_password=true
config_drive_raw_hhd=true
config_drive_cdrom=true
config_drive_vfat=true
bsdtar_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\bsdtar.exe
mtools_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\
verbose=true
debug=true
logdir=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\log\
logfile=cloudbase-init-unattend.log
default_log_levels=comtypes=INFO,suds=INFO,iso8601=WARN,requests=WARN
logging_serial_port_settings=
mtu_use_dhcp_config=true
ntp_use_dhcp_config=true
local_scripts_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts\
metadata_services=cloudbaseinit.metadata.services.ovfservice.OvfService
plugins=cloudbaseinit.plugins.common.mtu.MTUPlugin,cloudbaseinit.plugins.common.sethostname.SetHostNamePlugin,cloudbaseinit.plugins.windows.extendvolumes.ExtendVolumesPlugin
allow_reboot=false
stop_service_on_exit=false
check_latest_version=false
"@

#cloudbase-init.conf
$CloudbaseInitContents = @"
[DEFAULT]
username=Administrator
groups=Administrators
inject_user_password=true
first_logon_behaviour=always
config_drive_raw_hhd=true
config_drive_cdrom=true
config_drive_vfat=true
bsdtar_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\bsdtar.exe
mtools_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\
verbose=true
debug=true
logdir=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\log\
logfile=cloudbase-init.log
default_log_levels=comtypes=INFO,suds=INFO,iso8601=WARN,requests=WARN
logging_serial_port_settings=
mtu_use_dhcp_config=true
ntp_use_dhcp_config=true
local_scripts_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts\
metadata_services=cloudbaseinit.metadata.services.ovfservice.OvfService
plugins=cloudbaseinit.plugins.windows.createuser.CreateUserPlugin,cloudbaseinit.plugins.windows.setuserpassword.SetUserPasswordPlugin,cloudbaseinit.plugins.common.sshpublickeys.SetUserSSHPublicKeysPlugin,cloudbaseinit.plugins.common.userdata.UserDataPlugin
"@


New-Item -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" -ItemType File -Value $CloudbaseInitUnattendContents -Force
New-Item -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -ItemType File -Value $CloudbaseInitContents -Force
#Set-Content -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" -Value $CloudbaseInitUnattendContents
#Set-Content -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Value $CloudbaseInitContents