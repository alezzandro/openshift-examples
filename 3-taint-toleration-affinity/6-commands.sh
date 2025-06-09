# Apply the deployment
oc apply -f 6-nginx-anti-affinity.yaml

# Observe pods (should schedule on different nodes if multiple worker nodes available)
echo "Observing pod status and node assignment (should try to spread across nodes):"
oc get pod -o wide -w -l app=nginx-anti-affinity

# Clean up
oc delete -f 6-nginx-anti-affinity.yaml