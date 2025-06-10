# Label a node first (as shown above)
# For example: oc label node worker-node-01 node-type=gpu-enabled

# Apply the deployment
oc apply -f 5-nginx-node-affinity.yaml

# Observe pods (it should schedule on the labeled node)
echo "Observing pod status (should schedule on the labeled node):"
oc get pod -o wide -w -l app=nginx-node-affinity

# Clean up
oc delete -f 5-nginx-node-affinity.yaml
oc label node "$NODE_NAME_FOR_LABEL" node-type- # Remove label after demo