#!/bin/bash

docker pull thanikavel/prod:latest

docker stop devops-container || true

docker rm devops-container || true

docker run -d -p 80:80 --name devops-container thanik/prod:latest
