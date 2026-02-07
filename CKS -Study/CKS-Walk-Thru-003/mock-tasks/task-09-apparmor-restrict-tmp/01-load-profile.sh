#!/bin/bash
echo "[+] Loading AppArmor profile..."
sudo apparmor_parser -r 00-apparmor-profile
sudo apparmor_parser -r <(cat 00-apparmor-profile | sed 's/profile/profile deny-tmp/')
