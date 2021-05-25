#!/bin/bash

sudo apt-get -y update
sudo apt-get -y install gcc
sudo apt-get install make
# sudo apt-get install redis-tools
sudo apt-get install -y postgresql-client-common
sudo apt-get install -y postgresql-client-10
# wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make

# node:
sudo apt-get -y install curl dirmngr apt-transport-https lsb-release ca-certificates
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get -y install nodejs
sudo apt-get -y install gcc g++ make

sudo mkdir /app
sudo chown ubuntu /app

sudo apt-get install -y nfs-common

# for EFS:
sudo apt-get -y install git binutils
git clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

echo Mounting EFS...
sudo mkdir /app/data
sudo chown ubuntu /app/data
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $1:/  /app/data
echo EFS mounted.

# on MAC:
# brew install amazon-efs-utils
