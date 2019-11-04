#!/bin/bash

SHARED=$(pwd)/src/:/app/

function build(){
   docker network create --subnet=110.18.0.0/16 myTFNetDocker
   pip install localstack
   docker build -t herreraluis/terraform-mock-aws-prodiver . --network=host
}

function run(){
   docker run -v $SHARED --net myTFNetDocker --ip 110.18.0.102 --rm -ti \
   herreraluis/terraform-mock-aws-prodiver
}

function destroy(){
   docker run -v $SHARED --net myTFNetDocker --ip 110.18.0.102 --rm -ti \
   herreraluis/terraform-mock-aws-prodiver sh destroy.sh
}

function localstack(){
   docker run -it -e LOCALSTACK_HOSTNAME="localhost" -p 8080:8080  \
          --name localstack --rm \
          --net myTFNetDocker --ip 110.18.0.101 \
          -p 443:443 -p 4567-4583:4567-4583 -p 4590-4593:4590-4593 \
          -v "/tmp/localstack:/tmp/localstack" \
          -v "/var/run/docker.sock:/var/run/docker.sock" \
          -e DOCKER_HOST="unix:///var/run/docker.sock" \
          -e HOST_TMP_FOLDER="/tmp/localstack" "localstack/localstack"
}

function help(){
  echo "Terraform Mock AWS Provider With Docker and LocalStack:"
  echo "build       : build the docker image"
  echo "run         : run whats inside src/main.tf with terraform apply"
  echo "destroy     : destroy whats inside src/main.tf with terraform destroy"
  echo "localstack  : run docker image with localstack for mock local aws :)"
}

case $1 in
     "build")
          build
          ;;
      "run")
          run
          ;;
      "destroy")
          destroy
          ;;
      "localstack")
          localstack
          ;;
      *)
          help
esac
