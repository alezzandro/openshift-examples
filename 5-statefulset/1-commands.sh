# Apply the Headless Service
oc apply -f 1-nginx-headless-service.yaml

# Verify the service
oc get svc nginx-headless