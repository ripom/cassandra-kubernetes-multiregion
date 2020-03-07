#!/bin/bash
kubectl create configmap dse-config --from-file=../common/dse/conf-dir/resources/cassandra-6.0.0/conf --from-file=../common/dse/conf-dir/resources/dse-6.0.0/conf
kubectl apply -f DNS-AZURE-parameters.yaml
kubectl apply -f 'dse-AZURE-6.0.0-solr-DC2.yaml'
