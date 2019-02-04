#/bin/bash!

docker build -t maxbeck/$(oc project -q):latest -f ./Dockerfile --build-arg namespace=$(oc project -q) .
docker push maxbeck/$(oc project -q):latest
#kubectl run $(oc project -q) --image=maxbeck/$(oc project -q) --port 8080
kubectl create -f deployment.yaml
#kubectl scale deployment $(oc project -q) --replicas=1
kubectl create -f service.yaml
kubectl create -f servicemonitor.yaml
kubectl create -f route.yaml