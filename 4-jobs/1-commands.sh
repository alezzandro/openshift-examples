# Apply the Job
oc apply -f 1-simple-job.yaml

# Watch the Job status
echo "Watching Job status (should go to 1/1 completions):"
oc get job simple-echo-job -w

# Get the pod name created by the Job
JOB_POD_NAME=$(oc get pod -l job-name=simple-echo-job -o jsonpath='{.items[0].metadata.name}')

# Watch the pod status (should go from Running to Completed)
echo "Watching Pod status (should go to Completed):"
oc get pod "$JOB_POD_NAME" -w

# Get logs from the completed pod
echo "Fetching logs from the Job's pod:"
oc logs "$JOB_POD_NAME"

# Clean up
oc delete -f 1-simple-job.yaml