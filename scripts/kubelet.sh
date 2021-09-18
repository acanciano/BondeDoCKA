#! /bin/bash

K8S_VERSION="1.19.5-00"

# desabilitando swap
sudo swapoff -a

sudo apt install -y apt-transport-https ca-certificates gnupg2

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo bash -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'

sudo apt update

sudo apt install -y kubelet=$K8S_VERSION kubectl=$K8S_VERSION kybeadm=$K8S_VERSION

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable kubelet && sudo systemctl start kubelet