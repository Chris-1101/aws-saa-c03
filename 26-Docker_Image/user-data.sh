#!/usr/bin/env bash

# Shell Options
set -o errexit   # Exit immediately on non-zero command status
set -o xtrace    # Trace all commands

# Install wget & git
yum install wget git -y

# Download & Extract Dockerfile
cd /home/ec2-user/
wget https://learn-cantrill-labs.s3.amazonaws.com/awscoursedemos/0030-aws-associate-ec2docker/container.zip
unzip container.zip

