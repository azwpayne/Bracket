# Kali initialization configure

```shell
sudo apt -y update && apt -y upgrade && apt -y full-upgrade && apt -y autoclean && apt -y autoremove
sudo apt install -y apt-transport-https ca-certificates curl gnupg \
  lsb-release wget make gcc automake \
  autoconf libtool tree iftop nethogs ntp ntpdate
```

## install gnome desktop

```shell
sudo apt-get install -y kali-desktop-gnome
```
> 安装后选择gdm3重启即可

## install Input editor

```shell
apt-get install fcitx
apt-get install fcitx-googlepinyin
```
> apt-get install im-config, 执行im-config将输入法选择为fcitx
> 异常参见 https://blog.csdn.net/a1054756335/article/details/105504395/

## install  
```shell
sudo apt-get install linux-header-$(uname -r) 
```

```shell
sudo reboot
```