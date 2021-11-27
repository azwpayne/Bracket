#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# Install Kubernetes Cluster for redhat
# Get the first network card address
if [[ $(uname -s) == "Darwin" ]]; then
  ipaddrs=$(ifconfig en0 | grep -E "inet 1.*? netmask" | awk '{print $2}')
elif [[ $(uname -s) == "Linux" ]]; then
  ipaddrs=$(ifconfig eth0 | awk 'NR==2 {print $2}')
else
  echo "windows?"
fi

# close firewalld
systemctl disable firewalld && systemctl status firewalld

# close selinux
setenforce 0 && sed -i 's/enforcing/disabled/' /etc/selinux/config && getenforce

# close swap
swapoff -a && sed -ri 's/.*swap.*/#&/' /etc/fstab

# synchronised time
yum -y install ntp ntpdate timedatectl && ntpdate time.windows.com && systemctl start chronyd.service
timedatectl set-timezone Asia/Shanghai && timedatectl set-local-rtc 0 && systemctl restart rsyslog \
  systemctl restart crond.service

# Traffic forwarding
cat >/etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
net.ipv4.tcp_tw_recycle=1
vm.swappiness=0
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
fs.file-max = 52706963
fs.ns_open=52706963
net.ipv6.conf.all.disable_ipv6=1
net.netfilter.nf_conntrack_max=2310720
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
#yum install -y kubelet-1.16.1 kubectl-1.16.1 kubeadm-1.16.1
yum install -y kubelet-1.19.8 kubectl-1.19.8 kubeadm-1.19.8
systemctl enable kubelet
echo "exclude=kube*" >>/etc/yum.conf

# init
kubeadm init \
  --apiserver-advertise-address=192.168.0.27 \
  --image-repository registry.aliyuncs.com/google_containers \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16
