# Kali initialization configure

## time zone setting

```bash
dpkg-reconfihure tzdata &&
  apt install -y xfont-intl-chinese &&
  apt install tff-wqy-microhei

```

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