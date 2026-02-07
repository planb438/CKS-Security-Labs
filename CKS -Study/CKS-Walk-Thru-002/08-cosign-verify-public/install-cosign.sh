#!/bin/bash
COSIGN_VERSION="v2.2.3"
curl -Lo cosign https://github.com/sigstore/cosign/releases/download/$COSIGN_VERSION/cosign-linux-amd64
chmod +x cosign && sudo mv cosign /usr/local/bin/
