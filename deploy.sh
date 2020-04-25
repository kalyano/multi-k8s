docker build -t kalyano/multi-client:latest -t kalyano/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kalyano/multi-server:latest -t kalyano/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kalyanp/multi-worker:latest -t kalyano/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kalyano/multi-client:latest
docker push kalyano/multi-server:latest
docker push kalyano/multi-worker:latest
docker push kalyano/multi-client:$SHA
docker push kalyano/multi-server:$SHA
docker push kalyano/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kalyano/multi-server:$SHA
kubectl set image deployments/client-deployment client=kalyano/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kalyano/multi-worker:$SHA