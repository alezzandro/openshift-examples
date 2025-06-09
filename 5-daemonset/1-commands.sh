# Get a list of your nodes to confirm which are workers
echo "Listing cluster nodes:"
oc get nodes -o wide

# Apply the DaemonSet
echo "Applying the DaemonSet..."
oc apply -f 1-node-agent-daemonset.yaml

# Watch the DaemonSet status
echo "Watching DaemonSet status (should show DESIRED, CURRENT, READY matching worker node count):"
oc get daemonset node-agent-ds -w

# Observe pods and their node assignments (confirm one pod per worker node)
echo "Watching pods created by the DaemonSet (should see one on each worker node):"
oc get pod -l app=node-agent -o wide -w

# Get logs from one of the DaemonSet's pods
# (Replace <one-of-the-daemonset-pods-name> with an actual pod name from 'oc get pod' output)
DAEMONSET_POD_NAME=$(oc get pod -l app=node-agent -o jsonpath='{.items[0].metadata.name}')
echo "Fetching logs from pod: $DAEMONSET_POD_NAME"
oc logs -f "$DAEMONSET_POD_NAME" & # Run in background so you can continue commands

# Demonstrate DaemonSet's self-healing by deleting a pod
echo "Deleting one of the DaemonSet's pods to show self-healing..."
oc delete pod "$DAEMONSET_POD_NAME"

# Watch the DaemonSet status and pod status again to see a new pod spin up
echo "Watching for a new pod to appear on the same node:"
oc get pod -l app=node-agent -o wide -w

# Clean up
echo "Cleaning up the DaemonSet..."
oc delete -f 2-node-agent-daemonset.yaml