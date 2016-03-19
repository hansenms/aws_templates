#!/bin/bash

bucket_name=$1
iam_role_name=$2

sudo yum install -y wget automake fuse-devel gcc-c++ git libcurl-devel libxml2-devel make openssl-devel
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure --prefix=/usr
make -j $(nproc)
sudo make install

sudo mkdir -p /mnt/bucket
sudo s3fs ${bucket_name} /mnt/bucket -o allow_other -o iam_role=${iam_role_name}
