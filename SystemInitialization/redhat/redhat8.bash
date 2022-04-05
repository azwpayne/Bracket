#!/usr/bin/env bash
#!/usr/bin/env bash
# author: payne
# email: wuzhipeng1289690157@gmail.com
# system initialization

WORK_DIR=$(pwd)
# check user
## Root privileges are required when we initialize the system
[[ $EUID -ne 0 ]] && echo 'ERROR: This script must be run as root!' && exit 1

# Close selinux services
/bin/sed -i 's/mingetty tty/mingetty --noclear tty/' /etc/inittab
/bin/sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config
/bin/sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# Custom bash
/bin/cat <<EOF >>/etc/profile
#export PS1='\u@h:w\$ '
export PS1='[\u@dev W]$ '
EOF

# Close unuseful services
systemctl stop postfix &&
  systemctl disable 'postfix' &&
  systemctl disable 'NetworkManager' &&
  systemctl disable 'abrt-ccpp'

# add group and user
groupadd -g 20000 payne
useradd -g payne -u 20000 -s /bin/bash -c "Dev user" -m -d /home/payne payne
usermod -aG wheel payne
echo 'MDcxOXBheW5lOTUyNw' | passwd --stdin payne

## Configre sudoers
sed -i 's/^Defaults    requiretty/#Defaults    requiretty/' /etc/sudoers
sed -i 's/^Defaults    env_keep = "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR \/Defaults    env_keep = "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR SSH_AUTH_SOCK \/' /etc/sudoers

# Change Intel P-state
/bin/sed -i '/GRUB_CMDLINE_LINUX/{s/"$//g;s/$/ intel_pstate=disable intel_idle.max_cstate=0 processor.max_cstate=1 idle=poll"/}' /etc/default/grub

# Sysctl config
found=$(grep -c net.ipv4.tcp_tw_recycle /etc/sysctl.conf)
if ! [ $found -gt "0" ]; then
  cat >/etc/sysctl.conf <<EOF
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
fs.file-max = 131072
kernel.panic=1
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_no_metrics_save = 1
net.core.netdev_max_backlog = 3072
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_max_tw_buckets = 720000
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_fin_timeout = 5
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_retries1 = 2
net.ipv4.tcp_retries2 = 10
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_syncookies = 1
EOF
fi

sysctl -p

# Max open files
found=$(grep -c "^* soft nproc" /etc/security/limits.conf)
if ! [ $found -gt "0" ]; then
  cat >>/etc/security/limits.conf <<EOF
* soft nproc 2048
* hard nproc 16384
* soft nofile 8192
* hard nofile 65536
EOF
fi

# ssh config
/bin/sed -i 's/.*Port[[:space:]].*$/Port 9122/' /etc/ssh/ssh_config
/bin/sed -i 's/.*Port[[:space:]].*$/Port 9122/' /etc/ssh/sshd_config
/bin/sed -i 's/port="22"/port="9122"/' /usr/lib/firewalld/services/ssh.xml
firewall-cmd --reload

# update kernel
#rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
#rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
#yum --enablerepo=elrepo-kernel install -y kernel-lt
#grub2-set-default 0 && uname -r

## update or upgrade
sudo yum -y update && sudo yum -y upgrade && sudo yum group install -y "development tools"
sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*
## install package
sudo yum -y install epel-release curl gnupg conntrack ipvsadm ipset jq iptables sysstat libseccomp vim net-tools git
sudo yum -y install lsb-release wget make gcc automake autoconf libtool tree iftop nethogs ntp ntpdate yum-utils yum-config-manager
sudo yum -y install cmake autoconf automake perl-CPAN libcurl-devel gcc-c++ glibc-headers zlib-devel git-lfs telnet ctags
sudo yum -y install expat-devel openssl-devel tig bash-completion

### configure Command incomplete
echo "source /usr/share/bash-completion/bash_completion" >>/etc/profile
source /etc/profile

## configure time synchronization
#ntpdate time.windows.com

## git config
git config --global user.name "payne-wu"
git config --global user.email "wuzhipeng1289690157@gmail.com"
git config --global credential.helper store
git config --global core.longpaths true
git config --global core.quotepath off
git lfs install --skip-repo


