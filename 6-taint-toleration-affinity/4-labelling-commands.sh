# Get a list of your worker nodes to pick one
oc get nodes

# === DEMO: Labeling a node ===
# Replace <your-node-name> with an actual worker node name
NODE_NAME_FOR_LABEL="crc"

echo "Labeling node ${NODE_NAME_FOR_LABEL} with node-type=gpu-enabled..."
oc label node "$NODE_NAME_FOR_LABEL" node-type=gpu-enabled

echo "Verifying label on node ${NODE_NAME_FOR_LABEL}:"
oc describe node "$NODE_NAME_FOR_LABEL" | grep -A10 Labels

# === DEMO: Unlabeling a node (for cleanup or next steps) ===
echo "Unlabeling node ${NODE_NAME_FOR_LABEL}..."
oc label node "$NODE_NAME_FOR_LABEL" node-type- # The trailing '-' removes the label

echo "Verifying unlabel on node ${NODE_NAME_FOR_LABEL}:"
oc describe node "$NODE_NAME_FOR_LABEL" | grep -A10 Labels