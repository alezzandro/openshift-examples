# Ensure the node is still tainted from the previous step
# For example: oc describe node worker-node-01 | grep Taints

# Apply the deployment with toleration
oc apply -f 3-nginx-with-toleration.yaml

# Observe pods (it should schedule successfully on the tainted node)
echo "Observing pod status (should schedule on tainted node):"
oc get pod -o wide -w -l app=nginx-with-toleration

# Clean up
oc delete -f nginx-with-toleration.yaml
oc untaint node "$NODE_NAME_FOR_TAINT" app-specific=true:NoSchedule # Remove taint after demo