#!/bin/bash

set -ouex pipefail

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y \
    swayfx \
    swaylock-effects \
    swaylock-effects-zsh-completion \
    SwayNotificationCenter \
    SwayNotificationCenter-zsh-completion \
    sway-audio-idle-inhibit \
    waybar \
    swayidle
dnf install -y \
    dolphin \
    spectacle \
    qt6ct \
    ptyxis
dnf install -y sddm
dnf install -y \
    initial-setup \
    initial-setup-gui \
    initial-setup-gui-wayland-sway
systemctl set-default graphical.target
systemctl enable initial-setup.service
systemctl enable sddm
