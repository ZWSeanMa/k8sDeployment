# k8sDeployment
Making k8s deployment for Node.js Frontend .Net Backend and postgrsql database

# build docker image in backend repo then use deferent tag to build image for uat and prod image
docker build --build-arg ASPNETCORE_ENVIRONMENT=Development --build-arg TAG=dev -t meetlyomni-backend:dev .
docker build --build-arg ASPNETCORE_ENVIRONMENT=Production --build-arg TAG=prod -t meetlyomni-backend:prod .

# postgresql deployment
kubectl apply -f be-config-dev.yaml
kubectl apply -f postgres.yaml 

## verify whether the database running
kubectl get pods
kubectl logs -f postgres-0

## deploy the backend-uat 
kubectl apply -f backend-uat.yaml


kubectl port-forward svc/meetlyomni-backend-uat 5180:5180


kubectl delete -f be-config-dev.yaml
kubectl delete -f postgres.yaml
kubectl delete -f backend-uat.yaml


# frontend deployment
kubectl apply -f fe-config-dev.yaml
kubectl apply -f frontend-uat.yaml