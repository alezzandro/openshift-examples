# Apply the deployment
oc apply -f 1-nginx-ephemeral-deployment.yaml

# Wait for the pod to be running
oc get pods -w -l app=nginx-ephemeral

# Get the pod name
EPHEMERAL_POD_NAME=$(oc get pod -l app=nginx-ephemeral -o jsonpath='{.items[0].metadata.name}')

# Exec into the pod and create a file
oc exec "$EPHEMERAL_POD_NAME" -- bash -c "echo 'Ephemeral content lost on restart!' > /usr/share/nginx/html/index.html"

# Verify content
oc exec "$EPHEMERAL_POD_NAME" -- cat /usr/share/nginx/html/index.html

# Delete the pod (simulating failure/reschedule)
oc delete pod "$EPHEMERAL_POD_NAME"

# Wait for the new pod to come up
oc get pods -w -l app=nginx-ephemeral

# Get the new pod name
NEW_EPHEMERAL_POD_NAME=$(oc get pod -l app=nginx-ephemeral -o jsonpath='{.items[0].metadata.name}')

# Try to read the file from the new pod (it should be gone)
oc exec "$NEW_EPHEMERAL_POD_NAME" -- cat /usr/share/nginx/html/index.html
# Expected output: cat: /usr/share/nginx/html/index.html: No such file or directory

# Clean up
oc delete -f 1-nginx-ephemeral-deployment.yaml