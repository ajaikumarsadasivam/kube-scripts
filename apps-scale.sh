#!/bin/bash

# pass args - context, namesapce 
context=$1
ns=$2
FILE=app_replicas.json

# switch to the cluster-context
kubectl config use-context $context
echo "Scaling services for env: $ns"

d=0
while read dep ; do
   count=$(jq ".deployment[\"$dep\"]" $FILE)
   echo "Scaling $dep with replicas=$count"
   kubectl scale deploy $dep --replicas=$count -n $ns
   ((d++))
done < <(jq -r ".deployment|(keys[])" < $FILE)
echo "$d - deployment-service(s) Scaled.!"

s=0
while read sts ; do
   count=$(jq ".statefulset[\"$sts\"]" $FILE)
   echo "Scaling $sts with replicas=$count"
   kubectl scale sts $sts --replicas=$count -n $ns
   ((s++))
done < <(jq -r ".statefulset|(keys[])" < $FILE)
echo "$s - statefulset-service(s) Scaled.!"
