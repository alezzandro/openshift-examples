# Create a generic secret from literal values
oc create secret generic my-db-credentials \
  --from-literal=username=admin \
  --from-literal=password=s3cr3tDbP@ssword!

# Verify the secret
oc get secret my-db-credentials -o yaml
# To demonstrate decoding (optional, but good for understanding base64)
# echo "c3VwZXJzZWNyZXRwYXNzd29yZA==" | base64 --decode