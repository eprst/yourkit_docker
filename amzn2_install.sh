#!/usr/bin/env bash
set -e
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker $USER
sudo su - $USER # get new group
if [ -z "`mount | grep -n Snapshots`" ]; then
  mkdir -p Snapshots
  lsblk | grep -q nvme1n1 && (sudo mkfs.xfs -q -f /dev/nvme1n1 && sudo mount /dev/nvme1n1 Snapshots)
fi
sudo chown $USER Snapshots
docker run -p 5901:5901 -p 6901:6901 -v ~/Snapshots:/headless/Snapshots ksobolev/yourkit
