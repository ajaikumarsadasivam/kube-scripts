#!/bin/bash

# pass args - context, namesapce 
context=$1
ns=$2
rep=2

# switch to the cluster-context
kubectl config use-context $context
echo "Starting services for env: $ns"

# scale up apps
echo "Scaling up the Apps to $rep"
dcount=$(kubectl get deploy -n $ns | tail -n +2 | awk '{print $1}' | wc -l)
scount=$(kubectl get sts -n $ns | tail -n +2 | awk '{print $1}' | wc -l)

kubectl scale deploy,sts --all --replicas=$rep -n $ns
echo "$dcount - Deployment-service(s) Started.!"
echo "$scount - Statefulset-service(s) Started.!"
