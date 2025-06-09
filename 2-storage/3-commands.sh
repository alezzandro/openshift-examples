# Apply the PVC
oc apply -f 3-web-content-pvc.yaml

# Check the PVC status (should be 'Pending' briefly, then 'Bound')
oc get pvc web-content-pvc -w

# Check the dynamically created PV
oc get pv