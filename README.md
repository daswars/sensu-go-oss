# sensu-go-oss


## Default variables from sensu-go-backend image:
```
SENSU_BACKEND_CLUSTER_ADMIN_USERNAME: admin
SENSU_BACKEND_CLUSTER_ADMIN_PASSWORD: P@ssw0rd!
SENSU_BACKEND_API_URL: http://${SENSU_HOSTNAME}:8080
SENSU_BACKEND_ETCD_INITIAL_CLUSTER: default=http://${SENSU_HOSTNAME}:2380
SENSU_BACKEND_ETCD_ADVERTISE_CLIENT_URLS: http://${SENSU_HOSTNAME}:2379
SENSU_BACKEND_ETCD_INITIAL_ADVERTISE_PEER_URLS: http://${SENSU_HOSTNAME}:2380
SENSU_BACKEND_ETCD_LISTEN_CLIENT_URLS: http://[::]:2379
SENSU_BACKEND_ETCD_LISTEN_PEER_URLS: http://[::]:2380
WAIT_PORT: 2379
```

## Default variables from sensu-go-web image:

```
UPTREAM_LIST: backend1:8080 backend2:8080 backend3:8080
```
Default port is 80 (nginx)

## Note
The generate-nginx-upstream is unfortunately still very error-prone and does not like quotation marks. I still have to optimize it during the next days.


## Furthermore
More building stuff in the makefile

# Docker-Hub and docker pull infos

https://hub.docker.com/r/daswars/sensu-web-nginx
https://hub.docker.com/r/daswars/sensu

docker push daswars/sensu
docker push daswars/sensu-web-nginx

# docker-compose howto


docker-compose up -d

Sensu web UI: http://localhost

Sensu API: http://localhost:8080

Agent API: ws://localhost:8081

Name: admin
Password: P@ssw0rd!