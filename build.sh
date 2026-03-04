#!/bin/bash

docker build -t devops-build .

docker tag devops-build thanik/dev:latest

docker push thanik/dev:latest
