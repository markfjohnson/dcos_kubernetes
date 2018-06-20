#!/usr/bin/env bash
# This program will build python YAML files for Kubernetes Jobs
# args 1=K8s job name
#      2=python program
python build_yaml.py --job sample-job --src dcos_ping.py
python build_yaml.py --job  cassandra-rw  --src cassandra-rw.py
python build_yaml.py --job  mysql-rw  --src mysql-rw.py
