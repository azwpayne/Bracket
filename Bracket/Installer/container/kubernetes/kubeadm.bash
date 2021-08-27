#!/bin/bash

# Get the first network card address
if [[ $(uname -s) == "Darwin" ]]; then
  ipaddrs=$(ifconfig en0 | grep -E "inet 1.*? netmask" | awk '{print $2}')
elif [[ $(uname -s) == "Linux" ]]; then
  ipaddrs=$(ifconfig eth0 | awk 'NR==2 {print $2}')
else
  echo "windows?"
fi
# close firewalld
systemctl disable firewalld
## check firewall status
systemctl status firewalld

# close selinux
sed -i 's/enforcing/disabled/' /etc/selinux/config

# close swap
sed -ri 's/.*swap.*/#&/' /etc/fstab

# synchronised time
yum -y install ntp ntpdate && ntpdate time.windows.com && systemctl start chronyd.service

# Traffic forwarding
cat >/etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
vm.swappiness=0
EOF
sysctl --system

# Configure software mirroring
cat >/etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# yum list kubelet --showduplicates | sort -r
# install
yum install -y kubelet-1.16.1 kubectl-1.16.1 kubeadm-1.16.1
systemctl enable kubelet

# init
kubeadm init \
  --apiserver-advertise-address=192.168.0.27 \
  --image-repository registry.aliyuncs.com/google_containers \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16
