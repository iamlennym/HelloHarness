docker build -t solar-chain . 
docker tag solar-chain localhost:5000/solar-chain:latest
docker push localhost:5000/solar-chain:latest
