oc delete deployment bad-app
oc delete deployment app-with-env-secrets
oc delete deployment app-with-file-secrets
oc delete secret my-db-credentials
oc delete secret my-api-key
oc delete secret my-private-registry-creds # If you created it during demo
