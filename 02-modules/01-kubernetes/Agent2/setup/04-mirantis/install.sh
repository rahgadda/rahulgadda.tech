#!/bin/bash

# -- Installin cri-dockerd
VER=$(curl -s https://api.github.com/repos/Mirantis/cri-dockerd/releases/latest|grep tag_name | cut -d '"' -f 4)
echo $VER
wget https://github.com/Mirantis/cri-dockerd/releases/download/${VER}/cri-dockerd-${VER#?}.arm64.tgz
tar xvf cri-dockerd-${VER#?}.arm64.tgz
cd cri-dockerd
install -o root -g root -m 0755 cri-dockerd /usr/bin/cri-dockerd

# -- Verification
cri-dockerd --version

# -- Configure systemd units for cri-dockerd
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
cp cri-docker.socket cri-docker.service /etc/systemd/system/ 
cp cri-docker.socket cri-docker.service /usr/lib/systemd/system/

# -- Using cri-dockerd on new Kubernetes cluster
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket
systemctl status cri-docker.socket

# -- Update location
cd /home/opc

# -- Delete files
rm -rf cri-docker.service
rm -rf cri-docker.socket
rm -rf cri-dockerd-${VER#?}.arm64.tgz
rm -rf cri-dockerd