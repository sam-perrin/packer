# Maintainer: code@rainpole.io
# Packer variables for VMware Photon OS 3.0.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

#http_directory = "../../../configs/linux/photon-server"
boot_file      = "ks.json"
cd_files                    = ["../../../configs/linux/photon-server/*"]

# Virtual Machine Settings
vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "photon"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "3"
vm_guest_os_type            = "vmwarePhoton64Guest" 
vm_version                  = 17
vm_firmware                 = "bios"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 4096
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-photon-server-3.iso"
iso_checksum = "c65e13a8799d349b3f652afb2a2e5c9ff039e64fc9e20d12e88e4c56d9daeaed693c17d0c0a270f4658db19e803db867504beb65faa9382359b108b73dbfabc0"

# Scripts
# shell_scripts = ["../../../scripts/linux/photon-server-cleanup.sh"]
shell_scripts = [
  "../../../scripts/linux/photon/00-update.sh",
  "../../../scripts/linux/photon/01-network.sh",
  "../../../scripts/linux/photon/06-packages.sh",
  "../../../scripts/linux/photon/10-sshd.sh",
  "../../../scripts/linux/photon/11-clean-tmp.sh",
  "../../../scripts/linux/photon/20-cloudinit.sh",
  "../../../scripts/linux/photon/90-additional-clean.sh",
  "../../../scripts/linux/photon/95-motd.sh"
]