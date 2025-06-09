# Apply the deployment
oc apply -f 5-deployment-with-volume.yaml

# Wait for the pod to be running
oc get pods -w -l app=app-with-file-secrets

# Get the pod name
POD_NAME_FILE=$(oc get pod -l app=app-with-file-secrets -o jsonpath='{.items[0].metadata.name}')

# List files in the mounted secret directory
oc rsh "$POD_NAME_FILE" ls /etc/app-secrets/

# View the content of the secret file
oc rsh "$POD_NAME_FILE" cat /etc/app-secrets/api_key.txt