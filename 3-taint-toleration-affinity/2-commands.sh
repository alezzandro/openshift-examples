# Taint a node first (as shown above)
# For example: oc taint node worker-node-01 app-specific=true:NoSchedule

# Apply the deployment
oc apply -f 2-nginx-no-toleration.yaml

# Observe pods (it should stay in Pending if it can't schedule anywhere else)
echo "Observing pod status (should remain Pending on tainted node):"
oc get pod -o wide -w -l app=nginx-no-toleration

# Clean up
oc delete -f nginx-no-toleration.yaml