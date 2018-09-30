#!/usr/bin/env bash
set -e
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker $USER
sudo su - $USER # get new group
docker run -d -p 5901:5901 -p 6901:6901 ksobolev/yourkit
