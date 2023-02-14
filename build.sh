docker build -t hello-harness . 
docker tag hello-harness localhost:5000/hello-harness:latest
docker push localhost:5000/hello-harness:latest
