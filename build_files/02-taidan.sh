#!/bin/bash

set -ouex pipefail

dnf5 -y copr enable ublue-os/staging
dnf5 -y install taidan
dnf5 -y copr disable ublue-os/staging
systemctl preset-all
hostnamectl hostname birch
