#!/usr/bin/env bash
set -e

./mvnw clean package
docker build -t springdeveloper/spring-boot-crac-demo:builder-aarch64 .
docker run -d --privileged --rm --name=spring-boot-crac-demo --ulimit nofile=1024 -p 8080:8080 -v $(pwd)/target:/opt/mnt springdeveloper/spring-boot-crac-demo:builder-aarch64
echo "Please wait during creating the checkpoint..."
sleep 10
docker commit --change='ENTRYPOINT ["/opt/app/entrypoint.sh"]' $(docker ps -qf "name=spring-boot-crac-demo") springdeveloper/spring-boot-crac-demo:checkpoint-aarch64
docker kill $(docker ps -qf "name=spring-boot-crac-demo")
