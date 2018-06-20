#!/usr/bin/env bash
dcos package install --yes --cli dcos-enterprise-cli
dcos package install --yes mysql
dcos package install --yes hdfs

dcos marathon app add hdfs_client.json
dcos package install --yes marathon-lb
dcos package install --yes cassandra

dcos package install --yes spark --options=spark_options.json
dcos package install --yes kafka --options=kafka_options.json
dcos package install --yes jenkins
