# Get a list of your worker nodes to pick one
oc get nodes

# === DEMO: Tainting a node ===
# Replace <your-node-name> with an actual worker node name from 'oc get nodes' output
NODE_NAME_FOR_TAINT="crc" 

echo "Tainting node ${NODE_NAME_FOR_TAINT} with app-specific=true:NoSchedule..."
kubectl taint node "$NODE_NAME_FOR_TAINT" app-specific=true:NoSchedule

echo "Verifying taint on node ${NODE_NAME_FOR_TAINT}:"
oc describe node "$NODE_NAME_FOR_TAINT" | grep Taints

# === DEMO: Untainting a node (for cleanup or next steps) ===
echo "Untainting node ${NODE_NAME_FOR_TAINT}..."
kubectl taint node "$NODE_NAME_FOR_TAINT" app-specific:NoSchedule-

echo "Verifying untaint on node ${NODE_NAME_FOR_TAINT}:"
oc describe node "$NODE_NAME_FOR_TAINT" | grep Taints