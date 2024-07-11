#!/bin/bash

# pass args - context, namesapce 
context=$1
ns=$2
rep=0

# switch to the cluster-context
kubectl config use-context $context
echo "Stopping services for env: $ns"

# scale down apps
echo "Scaling down the Apps to $rep"
dcount=$(kubectl get deploy -n $ns | tail -n +2 | awk '{print $1}' | wc -l)
scount=$(kubectl get sts -n $ns | tail -n +2 | awk '{print $1}' | wc -l)

kubectl scale deploy,sts --all --replicas=$rep -n $ns
echo "$dcount - Deployment-service(s) Stopped.!"
echo "$scount - Statefulset-service(s) Stopped.!"
