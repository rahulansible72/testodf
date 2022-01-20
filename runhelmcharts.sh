## helm --kube-context ${control_cluster} upgrade cockroach-machine-pool ./charts/machine-pool -n ${cluster} --atomic -i -f /tmp/values.yaml
## --kube-context - to state which cluster to perform helm chart operations on.
## -n namespace
## --atomic - everything succeeds or fails
## -i do upgrade or new install
## -f path to default values.yaml
## 
## Helm should be run with the upgrade command
## helm upgrade odfoperator ./charts/odfoperator --atomic -i

## Command that did finally install the ocs operator from Red Hat
## helm install odfoperator ./charts/odfoperator -n openshift-operators
helm upgrade odfoperator ./charts/odfoperator -n openshift-operators
##  helm upgrade odfoperator ./charts/odfoperator --atomic -i -n openshift-operators 

## Need to add the command to run helm chart to install OCS storage cluster
## Possible command listed below

## helm install odfcluster ./charts/odfcluster -n openshift-operators
sleep 350s

helm upgrade odfcluster ./charts/odfcluster --atomic -i -n openshift-storage

