#!/bin/bash

docker build -t devops-build .

docker tag devops-build thanikavel/dev:latest

docker push thanik/dev:latest
