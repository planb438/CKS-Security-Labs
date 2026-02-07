#!/bin/bash

kubectl run sa-test   --rm -it   --restart=Never   --image=bitnami/kubectl   --namespace=task1   --overrides='{ "spec": { "serviceAccountName": "pod-reader" } }'   --command -- /bin/sh -c "kubectl get pods"