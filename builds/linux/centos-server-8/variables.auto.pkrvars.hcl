# Maintainer: code@rainpole.io
# Packer template for CentOS Server 8.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

#http_directory = "../../../configs/linux/centos-server"
http_file      = "ks-v8.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "8" 
vm_guest_os_type            = "centos8_64Guest" 
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

iso_file     = "iso-linux-centos-server-8.iso"
iso_checksum = "c19934697d286c9211bc38f6c2d000ef16519060f59319a3519a575e270546187b6f6a5852c21036c01b0a2a28e3be60147559c5e75906a20cafc8069dfce992"

# Scripts

shell_scripts = ["../../../scripts/linux/centos-server-cleanup.sh"]