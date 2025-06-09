# Apply the CronJob
oc apply -f 2-timestamp-cronjob.yaml

# Observe the CronJob
echo "Watching CronJob status (check LAST SCHEDULE column):"
oc get cronjob timestamp-logger-cronjob -w

# Observe Jobs created by the CronJob (will appear every minute)
echo "Watching Jobs created by the CronJob (new ones will appear every minute):"
oc get job -l cronjob=timestamp-logger-cronjob -w

# After 1-2 minutes, you should see a Job. Get its name and then its pod's name.
# (You might need to run this command a few times to get the latest pod)
echo "Getting the latest pod created by the CronJob:"
LATEST_CRONJOB_POD_NAME=$(oc get pod -l cronjob=timestamp-logger-cronjob --sort-by=.metadata.creationTimestamp -o jsonpath='{.items[-1].metadata.name}')
echo "Latest Pod Name: $LATEST_CRONJOB_POD_NAME"

# Get logs from the latest pod
echo "Fetching logs from the latest CronJob pod:"
oc logs "$LATEST_CRONJOB_POD_NAME"

# You can repeat the previous few steps to show multiple runs and logs.

# Clean up
oc delete -f 2-timestamp-cronjob.yaml