kubectl delete pod no-tmp-write --ignore-not-found
sudo apparmor_parser -R 00-apparmor-profile || true
