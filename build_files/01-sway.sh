#!/bin/bash

set -ouex pipefail

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y \
    swayfx \
    swaylock-effects \
    swaylock-effects-bash-completion \
    SwayNotificationCenter \
    SwayNotificationCenter-zsh-completion \
    sway-audio-idle-inhibit \
    initial-setup-gui-wayland-sway \
    waybar \
    swayidle \
    sway-systemd
dnf install -y \
    dolphin \
    spectacle \
    qt6ct \
    ptyxis
dnf install -y sddm
systemctl set-default graphical.target
systemctl enable sddm
systemctl enable initial-setup-graphical.service
