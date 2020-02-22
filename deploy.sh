docker build -t nicholaschris/multi-client:latest -t nicholaschris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nicholaschris/multi-server:latest -t nicholaschris/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nicholaschris/multi-worker:latest -t nicholaschris/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nicholaschris/multi-client:latest
docker push nicholaschris/multi-server:latest
docker push nicholaschris/multi-worker:latest

docker push nicholaschris/multi-client:$SHA
docker push nicholaschris/multi-server:$SHA
docker push nicholaschris/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nicholaschris/multi-server:$SHA
kubectl set image deployments/client-deployment client=nicholaschris/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nicholaschris/multi-worker:$SHA