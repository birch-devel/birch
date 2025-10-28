#!/bin/bash

set -ouex pipefail

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service
systemctl enable podman.socket

dnf -y install 'dnf5-command(config-manager)'
dnf config-manager setopt fedora-cisco-openh264.enabled=1

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf -y install \
    NetworkManager-wifi \
    atheros-firmware \
    brcmfmac-firmware \
    iwlegacy-firmware \
    iwlwifi-dvm-firmware \
    iwlwifi-mvm-firmware \
    mt7xxx-firmware \
    nxpwireless-firmware \
    realtek-firmware \
    tiwilink-firmware \
    firewalld

dnf -y remove console-login-helper-messages \
    chrony

dnf -y install \
    cifs-utils \
    gvfs-smb \
    plymouth \
    plymouth-system-theme \
    fwupd \
    libcamera{,-{v4l2,gstreamer,tools}} \
    whois \
    tuned \
    tuned-ppd \
    unzip \
    steam-devices \
    fuse-devel \
    fuse \
    fuse-common \
    rclone \
    uxplay \
    man-db \
    ifuse \
    libimobiledevice

systemctl enable firewalld

sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|^OnUnitInactiveSec=.*|OnUnitInactiveSec=7d\nPersistent=true|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

systemctl enable bootc-fetch-apply-updates

dnf -y copr enable ublue-os/packages
dnf -y copr disable ublue-os/packages
dnf -y --enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages install \
	ublue-brew \
	uupd \
	ublue-os-udev-rules

# ts so annoying :face_holding_back_tears: :v: 67
sed -i 's|uupd|& --disable-module-distrobox|' /usr/lib/systemd/system/uupd.service

systemctl enable brew-setup.service
systemctl enable uupd.timer

dnf swap -y ffmpeg-free ffmpeg --allowerasing

dnf install -y rpmfusion-free-release-tainted
dnf install -y libdvdcss

dnf install -y zsh
chsh -s $(which zsh)

