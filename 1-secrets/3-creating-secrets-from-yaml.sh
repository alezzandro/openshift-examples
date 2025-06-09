# Apply the secret
oc apply -f 3-api-key-secret.yaml

# Verify the secret
oc get secret my-api-key -o yaml