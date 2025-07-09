#!/bin/bash

: ${NODE_VERSION?"NODE_VERSION has not been set."}

set -x

function clean() {
  docker rm -f meteor-app
  docker rmi -f meteor-app-image
  rm -rf hello
}

cd /tmp
clean

meteor create --release 3.2 hello
cd hello
echo "FROM otud/meteord3.x_imagemagick:onbuild" > Dockerfile

docker build --platform linux/amd64 -t meteor-app-image ./
docker run -d \
    --platform linux/amd64 \
    --name meteor-app \
    -e ROOT_URL=http://yourapp_dot_com \
    -e MONGO_URL=mongodb://host.docker.internal:27017/test \
    -p 8080:80 \
    meteor-app-image

sleep 50

appContent=`curl http://localhost:8080`
clean

if [[ $appContent != *"yourapp_dot_com"* ]]; then
  echo "Failed: Meteor app"
  exit 1
fi