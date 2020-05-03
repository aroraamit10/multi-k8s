docker build -t aroraamit10/multi-client:latest -t aroraamit10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aroraamit10/multi-server:latest -t aroraamit10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aroraamit10/multi-worker:latest -t aroraamit10/multi-worder:$SHA -f ./worker/Dockerfile ./worker

docker push aroraamit10/multi-client:latest
docker push aroraamit10/multi-server:latest
docker push aroraamit10/multi-worker:latest

docker push aroraamit10/multi-client:$SHA
docker push aroraamit10/multi-server:$SHA
docker push aroraamit10/multi-worker:$SHA

kubectl delete -f k8s
kubectl set image deployments/server-deployment server=aroraamit10/multi-server:$SHA
kubectl set image deployments/client-deployment server=aroraamit10/multi-client:$SHA
kubectl set image deployments/worker-deployment server=aroraamit10/multi-worker:$SHA
