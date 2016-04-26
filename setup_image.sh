#!/bin/bash

docker_username=$1
docker_password=$2
docker_email=$3
docker_image=$4

#basic packages
apt-get update
apt-get install -y --no-install-recommends git emacs apt-transport-https ca-certificates curl python-pip cifs-utils samba smbclient jq

#docker 
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine
sudo apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y apparmor
apt-get install -y docker-engine
service docker start

#aws cli
sudo pip install awscli

#Download Docker image
docker login -u $docker_username -p $docker_password -e $docker_email
docker pull $docker_image
docker tag $docker_image current_gadgetron
