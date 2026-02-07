#!/bin/bash
kubectl create ns private-test

kubectl create secret docker-registry regcred \
  --docker-username=YOUR_DOCKERHUB_USERNAME \
  --docker-password=YOUR_DOCKERHUB_PASSWORD \
  --docker-email=you@example.com \
  -n private-test
