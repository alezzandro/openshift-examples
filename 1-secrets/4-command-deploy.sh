# Apply the deployment
oc apply -f 4-deployment-with-env.yaml

# Wait for the pod to be running
oc get pods -w -l app=app-with-env-secrets

# Get the pod name
POD_NAME_ENV=$(oc get pod -l app=app-with-env-secrets -o jsonpath='{.items[0].metadata.name}')

# Check environment variables inside the pod
oc rsh "$POD_NAME_ENV" env | grep -E "DB_USERNAME|DB_PASSWORD"