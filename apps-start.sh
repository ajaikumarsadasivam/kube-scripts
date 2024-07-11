#!/bin/bash

# pass args - context, namesapce 
context=$1
ns=$2
rep=2

# switch to the cluster-context
kubectl config use-context $context
echo "Starting services for env: $ns"

# scale up deployment
echo "Scaling up the deployment-apps to $rep"
dcount=$(kubectl get deploy -n $ns | tail -n +2 | awk '{print $1}' | wc -l)
kubectl scale deploy --replicas=$rep -n $ns
echo "$dcount - Deployment-service(s) Started.!"

# scale up statefulset
echo "Scaling up the statefulset-apps to $rep"
scount=$(kubectl get sts -n $ns | tail -n +2 | awk '{print $1}' | wc -l)
kubectl scale sts --replicas=$rep -n $ns
echo "$scount - Statefulset-service(s) Started.!"
