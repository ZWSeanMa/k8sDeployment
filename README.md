# k8sDeployment
Making k8s deployment for Node.js Frontend .Net Backend and postgrsql database

# build docker image in backend repo then use deferent tag to build image for uat and prod image
docker build --build-arg ASPNETCORE_ENVIRONMENT=Development --build-arg TAG=dev -t meetlyomni-backend:dev .
docker build --build-arg ASPNETCORE_ENVIRONMENT=Production --build-arg TAG=prod -t meetlyomni-backend:prod .

# postgresql deployment
kubectl apply -f postgres.yaml 

## verify whether the database running
kubectl get pods
kubectl logs -f postgres-0

kubectl apply -f be-config-dev.yaml
kubectl apply -f postgres.yaml
kubectl apply -f backend.yaml

kubectl apply -f be-config-dev.yaml
kubectl apply -f postgres.yaml
kubectl apply -f backend.yaml

kubectl delete -f be-config-dev.yaml
kubectl delete -f postgres.yaml
kubectl delete -f backend.yaml
