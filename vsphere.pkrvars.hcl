# Maintainer: code@rainpole.io

# Packer input variables for all builds.

##################################################################################
# VARIABLES
##################################################################################

# Credentials

vcenter_username = "{{env `VSPHEREUSER`}}"
vcenter_password = "{{env `VSPHEREPASS`}}"
build_username   = "{{env `LINUXUSER`}}"
build_password   = "{{env `LINUXPASS`}}"

# vSphere Objects

vcenter_insecure_connection     = true
vcenter_server                  = "{{env `VSPHEREVCENTER`}}"
vcenter_datacenter              = "{{env `VSPHEREDATACENTER`}}"
vcenter_cluster                 = "{{env `VSPHERECLUSTER`}}"
vcenter_datastore               = "{{env `VSPHEREDATASTORE`}}"
vcenter_network                 = "{{env `VSPHERENETWORK`}}"
vcenter_folder                  = "{{env `VSPHEREFOLDER`}}"
vcenter_content_library         = "Templates"

# ISO Objects

iso_datastore = "{{env `VSPHEREISODS`}} " # The [SPACE] is required.
iso_path      = "ISO"