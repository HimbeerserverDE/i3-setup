#! /bin/bash
# Install additional desktop programs
sudo -E apt install lightdm atril vlc firefox thunderbird

sudo cp -p i3.desktop /usr/share/xsessions/i3.desktop
sudo cp -p i3-with-shmlog.desktop /usr/share/xsessions/i3-with-shmlog.desktop
sudo cp -p lightdm.conf /etc/lightdm/lightdm.conf
