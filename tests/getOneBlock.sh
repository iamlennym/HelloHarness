if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <block id>"
else
	if [ "$SOLAR_CHAIN_ENV" == "prod" ]; then
		#curl http://192.168.49.2:32299/api/blocks | jq
		curl http://192.168.88.160:7000/api/blocks/$1 | jq
	else
		curl http://localhost:7000/api/blocks/$1 | jq
	fi
fi

