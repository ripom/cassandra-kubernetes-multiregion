kubectl create configmap opsc-config \
--from-file=../common/opscenter/conf-dir/agent/conf \
--from-file=../common/opscenter/conf-dir/conf \
--from-file=../common/opscenter/conf-dir/conf/event-plugins

kubectl create configmap opsc-ssl-config \
--from-file=../common/opscenter/conf-dir/conf/ssl

kubectl apply -f ../common/secrets/opsc-secrets.yaml

kubectl create configmap dse-config \
--from-file=../common/dse/conf-dir/resources/cassandra-6.0.0/conf \
--from-file=../common/dse/conf-dir/resources/dse-6.0.0/conf 

kubectl apply -f DNS-IBM-parameters.yaml

kubectl apply -f dse-IBM-6.0.0-solr-DC1.yaml
