#!/bin/bash
echo "[+] Showing audit log entry for secret read (if exists):"
sudo grep '"name":"test-audit"' /var/log/kubernetes/audit.log | jq .
