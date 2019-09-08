docker build -t freemancisco/multi-client:latest -t freemancisco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t freemancisco/multi-server:latest -t freemancisco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t freemancisco/multi-worker:latest -t freemancisco/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push freemancisco/multi-client:latest
docker push freemancisco/multi-server:latest
docker push freemancisco/multi-worker:latest

docker push freemancisco/multi-client:$SHA
docker push freemancisco/multi-server:$SHA
docker push freemancisco/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=freemancisco/multi-server:$SHA
kubectl set image deployments/client-deployment client=freemancisco/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=freemancisco/multi-worker:$SHA
