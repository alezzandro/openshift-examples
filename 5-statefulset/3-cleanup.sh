# Scale down to 0 replicas first to gracefully terminate all pods
oc scale statefulset nginx-statefulset --replicas=0

# Delete the StatefulSet
oc delete -f 2-nginx-statefulset.yaml

# Delete the Headless Service
oc delete -f 1-nginx-headless-service.yaml

# Manually delete the Persistent Volume Claims.
# This will also delete the underlying Persistent Volumes if their reclaim policy is 'Delete' (common for dynamic provisioning).
oc get pvc -l app=nginx-sts -o name | xargs oc delete
# or
# oc delete pvc data-nginx-statefulset-0 data-nginx-statefulset-1 # if you know the names