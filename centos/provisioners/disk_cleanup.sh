#!/bin/bash -eux
# Clean Yum
yum clean all

# Zero out the rest of the free space using dd, then delete the written file.
echo "Writing zeroes to free space (this could take a while)."
dd if=/dev/zero of=/EMPTY bs=1M
echo "Removing zero'd file"
rm -f /EMPTY
echo "$(date): Disk cleanup completed."
# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync