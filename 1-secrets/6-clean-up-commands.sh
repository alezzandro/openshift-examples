oc delete all --selector app=bad-app
oc delete all --selector app=app-with-env-secrets
oc delete all --selector app=app-with-file-secrets
oc delete secret my-db-credentials
oc delete secret my-api-key
oc delete secret my-private-registry-creds # If you created it during demo
