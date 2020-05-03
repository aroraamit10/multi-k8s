docker build -t amitairtel09/multi-client:latest -t amitairtel09/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amitairtel09/multi-server:latest -t amitairtel09/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitairtel09/multi-worker:latest -t amitairtel09/multi-worder:$SHA -f ./worker/Dockerfile ./worker

docker push amitairtel09/multi-client:latest
docker push amitairtel09/multi-server:latest
docker push amitairtel09/multi-worker:latest

docker push amitairtel09/multi-client:$SHA
docker push amitairtel09/multi-server:$SHA
docker push amitairtel09/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitairtel09/multi-server:$SHA
kubectl set image deployments/client-deployment server=amitairtel09/multi-client:$SHA
kubectl set image deployments/worker-deployment server=amitairtel09/multi-worker:$SHA
