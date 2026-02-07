#!/bin/bash
kubectl exec -n ops busybox-debugger -- sh -c 'echo "trigger exec for falco"'
sleep 2
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10s
