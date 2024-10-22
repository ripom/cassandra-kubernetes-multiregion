# cassandra-kubernetes-multiregion
With this project I am going to illustrate how is possible to deploy a Cassandra Datastax database on Kubernetes (AKS) across Azure multi-region. To make it possible I am using a DNS sidecar published on this link https://github.com/ripom/pods-autoregister-dns

Bear in mind this has a didactic scope. It should not be used in production because has not been fully tested and some configuration are not  supported yet or are deprecated already by Datastax.

The attached files are relative to either a deployment in Azure across 2 AKS cluster or a deployment in IBM Cloud across 2 IKS clusters

```File Structure
common folder	    contains all pre-requisite to  deploy Cassandra DSE in Kubernetes, those files will be used by the script in azure/ibm folders
azure folder	    contains all script files to deploy Cassandra DSE on kubernetes in different AKS cluster
ibm folder          contains all script files to deploy Cassandra DSE on kubernetes in different IKS cluster
terraform folder    contains an Azure terraform deployment script to build a demo infrastructure composed by 2 VNET in different regions, 2 AKS in different regions connected in respective VNET. The VNER are connected using global peering, Then a Azure Private DNS linked to both VNET
```

To run the Azure demo, follow the steps for the infrastructure deployment:
1. Create a Resource Group to create the Demo resources in.
2. Clone the project
3. Login to Azure subscription
4. Change the path to terraform folder
5. Initialize the terraform with terraform init command
6. Apply the terraform configuration, providing the resource group name created in the first step and the password that you want assign to the service principals (the SPs will be created by terraform)

``` Run Infrastructure Command
git clone https://github.com/ripom/cassandra-kubernetes-multiregion.git
az login
cd cassandra-kubernetes-multiregion/terraform
terraform init
terraform apply --var=infrastructure-rg=xxxxxxxxxx --var=aks_client_secret=xxxxxxxxxxxxxxxxx 

```
Once the infrastructure is ready, an output will be generated by terraform, copy the output values in the ../azure/DNS-AZURE-parameters.yaml file:
``` Terraform output
        subscription_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        ResourceGroup: "xxxxxxxxxxxxxx"
        DnsZone: "xxxxxxxxxxxxxxx"
        TENANT_ID: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        CLIENT: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        KEY: "xxxxxxxxxxxxxxxxxxxx"
```
Finally you can deploy Cassandra Cluster.

``` Run Application Command
cd ../azure
Connect to the first AKS cluster with the command: az aks get-credential -g <resourcegroup> -n cdt-aks-westeurope
Deploy Cassandra in the first datacenter with command: sh ./deploy-Azure-DSE-DC1.sh (This script will form the Cassandra ring with 3 nodes in one DC)
Wait all 3 Cassandra DSE pods are running (kubectl get pods -w), you could to wait 10/15 minutes.

Then connect to the second AKS cluster with the command: az aks get-credential -g <resourcegroup> -n cdt-aks-southeastasia
Deploy Cassandra in the second datacenter with command: sh ./deploy-Azure-DSE-DC2.sh (This script will join 2 more Cassandra nodes to the existing ring in the second DC)

