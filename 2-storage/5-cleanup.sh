# Delete the deployment
oc delete -f 4-nginx-persistent-deployment.yaml

# The PVC will remain 'Bound' until deleted
oc get pvc web-content-pvc

# Delete the PVC (this will also delete the underlying PV if reclaim policy is 'Delete')
oc delete -f 3-web-content-pvc.yaml

# Verify PV is gone (or remains if reclaim policy is 'Retain')
oc get pv