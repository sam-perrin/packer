#!/bin/bash  -eux
### Disable and clean tmp. ### 
echo '> Disabling and clean tmp ...'
sudo sed -i 's/D/#&/' /usr/lib/tmpfiles.d/tmp.conf