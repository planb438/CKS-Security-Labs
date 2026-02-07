#!/bin/bash

echo "[+] Cleaning up SBOM scanning task..."

# Remove local image (Podman)
podman rmi sbom-demo:1.0 --force 2>/dev/null || true

# Remove generated SBOM file
rm -f sbom.json

# Remove any lingering build layers (optional)
podman image prune -f > /dev/null

echo "[✓] Cleanup complete."vi cleanup.sh