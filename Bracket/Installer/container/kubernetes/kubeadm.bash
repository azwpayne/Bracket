#!/bin/bash

# Get the first network card address
if [[ $(uname -s) == "Darwin" ]]; then
  ipaddrs=$(ifconfig en0 | grep -E "inet 1.*? netmask" | awk '{print $2}')
elif [[ $(uname -s) == "Linux" ]]; then
  ipaddrs=$(ifconfig eth0 | awk 'NR==2 {print $2}')
else
  echo "windows?"
fi
# close firewalld and check firewall status
systemctl disable firewalld && systemctl status firewalld

# close selinux
sed -i 's/enforcing/disabled/' /etc/selinux/config

# close swap
sed -ri 's/.*swap.*/#&/' /etc/fstab

# synchronised time
yum -y install gcc automake autoconf libtool make gcc-c++ yum-utils iftop nethogs ntp ntpdate &&
  ntpdate time.windows.com &&
  systemctl start chronyd.service

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

# View all version
# yum list --showduplicates kubelet
# install
yum install -y kubelet-1.18.20-0 kubectl-1.18.20-0 kubeadm-1.18.20-0
systemctl enable kubelet && systemctl enable kubelet.service
# init
kubeadm init \
  --apiserver-advertise-address=$ipaddrs \
  --image-repository registry.aliyuncs.com/google_containers \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16

########################
#kubeadm init \
#  --apiserver-advertise-address=192.168.0.244 \
#  --image-repository registry.aliyuncs.com/google_containers \
#  --service-cidr=10.96.0.0/12 \
#  --pod-network-cidr=10.244.0.0/16
########

# configure CNI
echo "199.232.28.133 raw.githubusercontent.com" >>/etc/hosts
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Enable IPVS and change the mode of kube-system/kube-proxy in the ConfigMap to IPVS
kubectl edit cm kube-proxy -n kube-system

# Configuration hint
echo "source <(kubectl completion bash)" >>~/.bashrc && source ~/.bashrc

# uninstall
#sudo kubeadm reset -f
#sudo rm -rvf $HOME/.kube
#sudo rm -rvf ~/.kube/
#sudo rm -rvf /etc/kubernetes/
#sudo rm -rvf /etc/systemd/system/kubelet.service.d
#sudo rm -rvf /etc/systemd/system/kubelet.service
#sudo rm -rvf /usr/bin/kube*
#sudo rm -rvf /etc/cni
#sudo rm -rvf /opt/cni
#sudo rm -rvf /var/lib/etcd
#sudo rm -rvf /var/etcd
#sudo yum remove kube*
