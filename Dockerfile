ARG packer_version=1.7.0

FROM hashicorp/packer:$packer_version

COPY . .