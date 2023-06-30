#!/usr/bin/env bash
set -e

docker run --rm -p 8080:8080 --name spring-boot-crac-demo springdeveloper/spring-boot-crac-demo:checkpoint
