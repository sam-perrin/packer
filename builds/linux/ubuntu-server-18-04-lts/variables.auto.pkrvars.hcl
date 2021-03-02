# Maintainer: code@rainpole.io
# Packer variables for Ubuntu Server 18.04 LTS.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

#http_directory = "../../../configs/linux/ubuntu-server"
http_file      = "ks.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "ubuntu"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "18-04-lts" 
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
vm_floppy_files_ubuntu1804 = [
  "../../../configs/linux/ubuntu-server/ks.cfg"
]

# ISO Objects

iso_file     = "iso-linux-ubuntu-server-18-04-lts.iso"
iso_checksum = "43738d7dfd3e2661e4d55d2e0f9d8150f0687f4335af9b4dac047bf45fafcb4a4831685281fd5a318c5747681c351375d1129094d3f1bf38d88ab4bb49b6c457"

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