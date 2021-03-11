# Maintainer: code@rainpole.io
# Packer variables for Ubuntu Server 20.04 LTS.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

#http_directory = "../../../configs/linux/ubuntu-server"
cd_files                    = ["../../../configs/linux/ubuntu-server/meta-data","../../../configs/linux/ubuntu-server/user-data"]

# Virtual Machine Settings
vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "ubuntu"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "20-04-lts" 
vm_guest_os_type            = "ubuntu64Guest" 
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

iso_file     = "iso-linux-ubuntu-server-20-04.iso"
iso_checksum = "6ff96a5997bf0ae1c8dfd7c5ce6bf53d9142397a147ebd24256f302e91e733dc8c165b265bd95f1cc07dbaa763a4ac7b4c1cd955aef818f0f37e1642a4be5840"

# Scripts
# shell_scripts = ["../../../scripts/linux/ubuntu-server-cleanup.sh"]
shell_scripts = [
  "../../../scripts/linux/ubuntu/00-update.sh",
  "../../../scripts/linux/ubuntu/06-packages.sh",
  "../../../scripts/linux/ubuntu/10-sshd.sh",
  "../../../scripts/linux/ubuntu/11-clean-tmp.sh",
  "../../../scripts/linux/ubuntu/20-cloudinit.sh",
  "../../../scripts/linux/ubuntu/90-additional-clean.sh",
  "../../../scripts/linux/ubuntu/95-motd.sh"
]