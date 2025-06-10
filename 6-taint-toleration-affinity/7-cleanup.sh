# Delete all resources created during the demo
oc delete all --selector app=nginx-no-toleration
oc delete all --selector app=nginx-with-toleration
oc delete all --selector app=nginx-node-affinity
oc delete all --selector app=nginx-anti-affinity

# Remove any remaining taints/labels from nodes
# Replace <your-node-name> with the node names you used
# oc untaint node <your-node-name> app-specific=true:NoSchedule
# oc label node <your-node-name> node-type-