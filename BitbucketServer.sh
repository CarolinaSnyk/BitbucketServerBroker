docker pull snyk/broker:bitbucket-server

docker pull snyk/code-agent

docker network create mySnykBrokerNetwork

#to confirm the network was created
docker network ls

#create a private file in the local directory and place the accept.json file in there (/home/private)

docker run --restart=always \
           -p 8000:8000 \
           -e BROKER_TOKEN=secret-broker-token \
           -e BITBUCKET_USERNAME=username \
           -e BITBUCKET_PASSWORD=password \
           -e BITBUCKET=bitbucket-server.domain.com:<port> \
           -e BITBUCKET_API=bitbucket-server.domain.com:<port>/rest/api/1.0 \
           -e BROKER_CLIENT_URL=http://my.broker.client:8000 \
           -e PORT=8000 \
           -e ACCEPT=/private/accept.json
           -v /local/path/to/private:/private \
           -e GIT_CLIENT_URL=http://code-agent:3000 \
           --network mySnykBrokerNetwork \
       snyk/broker:bitbucket-server

#to run the code agent
docker run --name code-agent \
    -p 3000:3000 \
    -e PORT=3000 -e SNYK_TOKEN=<token> --network mySnykBrokerNetwork \
     snyk/code-agent
