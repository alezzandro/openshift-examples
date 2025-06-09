# Apply the StatefulSet
oc apply -f 2-nginx-statefulset.yaml

# Observe ordered pod creation (nginx-sts-0 first, then nginx-sts-1)
echo "Watching StatefulSet pod creation (should be ordered 0 then 1):"
oc get pod -o wide -w -l app=nginx-sts

# Verify the PersistentVolumeClaims created
echo "Verifying PersistentVolumeClaims created by the StatefulSet:"
oc get pvc -l app=nginx-sts

# === Demonstrate Stable Hostnames and Writing Data ===
echo "Writing unique data to each pod's volume..."
oc exec nginx-statefulset-0 -- bash -c "echo 'Hello from StatefulSet Pod 0 at $(date)' > /usr/share/nginx/html/index.html"
oc exec nginx-statefulset-1 -- bash -c "echo 'Hello from StatefulSet Pod 1 at $(date)' > /usr/share/nginx/html/index.html"

echo "Verifying content on Pod 0:"
oc exec nginx-statefulset-0 -- cat /usr/share/nginx/html/index.html
echo "Verifying content on Pod 1:"
oc exec nginx-statefulset-1 -- cat /usr/share/nginx/html/index.html

echo "Verifying stable hostname for Pod 0:"
oc exec nginx-statefulset-0 -- hostname -f

# === Demonstrate Data Persistence (crucial step!) ===
echo "Deleting nginx-statefulset-0 to show data persistence..."
oc delete pod nginx-statefulset-0

# Watch for the new pod to come up
echo "Watching for nginx-statefulset-0 to restart..."
oc get pod -o wide -w -l app=nginx-sts

# Verify content on the new nginx-statefulset-0 pod (should be the original data)
echo "Verifying original content on the restarted nginx-statefulset-0:"
oc exec nginx-statefulset-0 -- cat /usr/share/nginx/html/index.html

# === Demonstrate Ordered Scaling Down ===
echo "Scaling down StatefulSet to 1 replica (nginx-statefulset-1 should terminate first):"
oc scale statefulset nginx-statefulset --replicas=1

echo "Watching pods during scale down:"
oc get pod -o wide -w -l app=nginx-sts