#!/usr/bin/env bash
kubectl cp <file-spec-src> <file-spec-dest> -c <specific-container>
python build_yaml.py $1 $2
