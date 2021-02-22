# Maintainer: code@rainpole.io
# Packer variables for VMware Photon OS 4.0.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

http_directory = "../../../configs/linux/photon-server"
http_file      = "ks.json"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "photon"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "4-beta"
vm_guest_os_type            = "vmwarePhoton64Guest" 
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

iso_file     = "iso-linux-photon-server-4.iso"
iso_checksum = "eb37c4cbd7a9812a2892f5bcbb7873cec211d544895ce38244b031368d8791c4cee21a8e3b7fb98175bf008bb21aa9530a507ffa24f7af83457869da6f396c6d"

# Scripts

shell_scripts = ["../../../scripts/linux/photon-server-cleanup.sh"]