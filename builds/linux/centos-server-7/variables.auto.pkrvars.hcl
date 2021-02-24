# Maintainer: code@rainpole.io
# Packer variables for CentOS Server 7.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

#http_directory = "../../../configs/linux/centos-server"
http_file      = "ks-v7.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "7"
vm_guest_os_type            = "centos7_64Guest" 
vm_version                  = 17
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 4096
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-centos-server-7.iso"
iso_checksum = "7061fa737086370716885439353b50da47d239ad81b971a0427ebb69b0ca65bcd7309bf211827ecfccd8a725b10ff5cc2a2ce395af5bcc559d08d7ce8b56ffe7"

# Scripts

shell_scripts = ["../../../scripts/linux/centos-server-cleanup.sh"]