#!/bin/bash

label_infra_nodes () {
  OCS_1A_NODES=$(oc get nodes --selector=topology.kubernetes.io/zone=us-east-1a,cluster.ocs.openshift.io/openshift-storage --no-headers | awk '{print $1}')
  OCS_1B_NODES=$(oc get nodes --selector=topology.kubernetes.io/zone=us-east-1b,cluster.ocs.openshift.io/openshift-storage --no-headers | awk '{print $1}')
  OCS_1C_NODES=$(oc get nodes --selector=topology.kubernetes.io/zone=us-east-1c,cluster.ocs.openshift.io/openshift-storage --no-headers | awk '{print $1}')
  OCS_1D_NODES=$(oc get nodes --selector=topology.kubernetes.io/zone=us-east-1d,cluster.ocs.openshift.io/openshift-storage --no-headers | awk '{print $1}')

}


echo "Patching Machine AutoScaler for ocsworker MachineSets"
  oc patch -n openshift-machine-api machineautoscaler ocsworker-1a --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 2 }]'
  oc patch -n openshift-machine-api machineautoscaler ocsworker-1b --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 2 }]'
  oc patch -n openshift-machine-api machineautoscaler ocsworker-1c --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 2 }]'
  oc patch -n openshift-machine-api machineautoscaler ocsworker-1d --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 2 }]'

  echo "Scaling ocsworker MachineSets to two worker node per AZ"
  oc scale --replicas=2 machineset ocsworker-1a -n openshift-machine-api
  oc scale --replicas=2 machineset ocsworker-1b -n openshift-machine-api
  oc scale --replicas=2 machineset ocsworker-1c -n openshift-machine-api
  oc scale --replicas=2 machineset ocsworker-1d -n openshift-machine-api

 