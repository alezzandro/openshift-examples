# Apply the bad deployment
oc apply -f 1-bad-deployment.yaml

# Wait for the pod to be running
oc get pods -w

# Get the pod name
POD_NAME=$(oc get pod -l app=bad-app -o jsonpath='{.items[0].metadata.name}')

# Inspect the pod configuration (show how easy it is to find)
oc get pod "$POD_NAME" -o yaml | grep -A 2 DB_PASSWORD_HARDCODED

# Or even exec into the pod and see environment variables
oc rsh "$POD_NAME" env | grep DB_PASSWORD_HARDCODED

# Clean up
oc delete -f 1-bad-deployment.yaml