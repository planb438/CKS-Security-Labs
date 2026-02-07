#!/bin/bash
kubectl delete pod risky-pod --ignore-not-found
kubectl delete clusterpolicy block-host-access --ignore-not-found
