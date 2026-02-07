#!/bin/bash
kubectl label ns ops pod-security.kubernetes.io/enforce=restricted --overwrite
