echo "Patching Machine AutoScaler for Compute MachineSets"
oc patch -n openshift-machine-api machineautoscaler compute-1a --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 1 }]'
oc patch -n openshift-machine-api machineautoscaler compute-1b --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 1 }]'
oc patch -n openshift-machine-api machineautoscaler compute-1c --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 1 }]'
oc patch -n openshift-machine-api machineautoscaler compute-1d --type json -p='[{ "op": "replace", "path": "/spec/minReplicas", "value": 1 }]'

echo "Scaling Compute MachineSets"
oc scale --replicas=1 machineset compute-1a -n openshift-machine-api
oc scale --replicas=1 machineset compute-1b -n openshift-machine-api
oc scale --replicas=1 machineset compute-1c -n openshift-machine-api
oc scale --replicas=1 machineset compute-1d -n openshift-machine-api

#echo "Waiting for Machine Deployments..."
#if ask "Ready to continue? (after machines and nodes are deployed and ready)" Y; then
OCS_1A_NODE=$(oc get nodes --selector=machine.openshift.io/cluster-api-machineset=compute-1a --no-headers | awk '{print $1}')
echo "Zone 1A: $OCS_1A_NODE"
OCS_1B_NODE=$(oc get nodes --selector=machine.openshift.io/cluster-api-machineset=compute-1b --no-headers | awk '{print $1}')
echo "Zone 1B: $OCS_1B_NODE"
OCS_1C_NODE=$(oc get nodes --selector=machine.openshift.io/cluster-api-machineset=compute-1c --no-headers | awk '{print $1}')
echo "Zone 1C: $OCS_1C_NODE"
OCS_1D_NODE=$(oc get nodes --selector=machine.openshift.io/cluster-api-machineset=compute-1d --no-headers | awk '{print $1}')
echo "Zone 1D: $OCS_1D_NODE"

oc label node ${OCS_1A_NODE} node-role.kubernetes.io/infra="" cluster.ocs.openshift.io/openshift-storage=""
oc label node ${OCS_1B_NODE} node-role.kubernetes.io/infra="" cluster.ocs.openshift.io/openshift-storage=""
oc label node ${OCS_1C_NODE} node-role.kubernetes.io/infra="" cluster.ocs.openshift.io/openshift-storage=""
oc label node ${OCS_1D_NODE} node-role.kubernetes.io/infra="" cluster.ocs.openshift.io/openshift-storage=""
