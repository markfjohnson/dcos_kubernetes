#!/usr/bin/env bash
docker build -f Dockerfile_python -t markfjohnson/python-k8s .
docker push markfjohnson/python-k8s
