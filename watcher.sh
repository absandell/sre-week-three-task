namespace="sre"
deployment="swype-app"
maxRestarts=3

while true; do
    numRestarts=$(kubectl get pods -n $namespace | grep $deployment | awk '{print $4}')
    podName=$(kubectl get pods -n $namespace | grep $deployment | awk '{print $1}')
    echo "Restarts for pod $podName in namespace $namespace for deployment $deployment = $numRestarts"
    
    if (( numRestarts > maxRestarts))
    then
        echo "Scaling down due to "$numRestarts" on pod "$podName"..."
        kubectl scale --replicas=0 deployment/${deployment} -n ${namespace}
        break
    fi

    sleep 60
done