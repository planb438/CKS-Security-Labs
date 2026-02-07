#!/bin/bash
kubectl create ns verify-task || true
kubectl create secret generic cosign-pubkey \
  --from-file=cosign.pub \
  -n verify-task
