#!/bin/bash

set -ouex pipefail

cp /ctx/taidan.repo /etc/yum.repos.d/taidan.repo
dnf5 update -y
dnf5 -y install taidan
rm /etc/yum.repos.d/taidan.repo
dnf5 update -y
systemctl preset-all
hostnamectl hostname birch
