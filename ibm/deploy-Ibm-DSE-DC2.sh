
kubectl create configmap dse-config \
--from-file=../common/dse/conf-dir/resources/cassandra-6.0.0/conf \
--from-file=../common/dse/conf-dir/resources/dse-6.0.0/conf 

kubectl apply -f DNS-IBM-parameters.yaml

kubectl apply -f dse-IBM-6.0.0-solr-DC2.yaml
