# Apply the deployment
oc apply -f 4-nginx-persistent-deployment.yaml

# Wait for the pod to be running
oc get pods -w -l app=nginx-persistent

# Get the pod name
PERSISTENT_POD_NAME=$(oc get pod -l app=nginx-persistent -o jsonpath='{.items[0].metadata.name}')

# Check the mount point inside the container
oc exec "$PERSISTENT_POD_NAME" -- df -h /usr/share/nginx/html

# Create a file on the persistent volume
oc exec "$PERSISTENT_POD_NAME" -- bash -c "echo 'Hello from Persistent Storage!' > /usr/share/nginx/html/index.html"

# Verify content
oc exec "$PERSISTENT_POD_NAME" -- cat /usr/share/nginx/html/index.html

# Delete the pod (simulating failure/reschedule)
oc delete pod "$PERSISTENT_POD_NAME"

# Wait for the new pod to come up
oc get pods -w -l app=nginx-persistent

# Get the new pod name
NEW_PERSISTENT_POD_NAME=$(oc get pod -l app=nginx-persistent -o jsonpath='{.items[0].metadata.name}')

# Try to read the file from the new pod (it should still be there!)
oc exec "$NEW_PERSISTENT_POD_NAME" -- cat /usr/share/nginx/html/index.html