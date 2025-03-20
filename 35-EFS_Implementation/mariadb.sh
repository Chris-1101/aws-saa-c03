#!/usr/bin/env bash

# Shell Options
set -o errexit   # Exit immediately on non-zero command status
set -o xtrace    # Trace all commands

# Pull Config Parameters from SSM
DBName=$(aws ssm get-parameter --name '/saa/a4l/db_name' --query 'Parameter.Value' --output 'text')
DBUser=$(aws ssm get-parameter --name '/saa/a4l/db_user' --query 'Parameter.Value' --output 'text')
DBPassword=$(aws ssm get-parameter --name '/saa/a4l/db_pass' --with-decryption --query 'Parameter.Value' --output 'text')
DBRootPassword=$(aws ssm get-parameter --name '/saa/a4l/db_root_pass' --with-decryption --query 'Parameter.Value' --output 'text')

# Download Packages
dnf install wget mariadb105-server cowsay amazon-cloudwatch-agent -y

# Enable Daemon
systemctl enable --now mariadb

# Configure CloudWatch Agent
mkdir -p /usr/share/collectd/
touch /usr/share/collectd/types.db
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/saa/a4l/cw_agent_config -s

# Create DB Query
cat << EOF > /tmp/setup.sql
CREATE DATABASE $DBName;
CREATE USER '$DBUser' IDENTIFIED BY '$DBPassword';
GRANT ALL PRIVILEGES ON *.* TO '$DBUser'@'%';
FLUSH PRIVILEGES;
EOF

cat /tmp/setup.sql

# Setup DB
mysqladmin -u root password "$DBRootPassword"
mysql -u root --password="$DBRootPassword" < /tmp/setup.sql
rm /tmp/setup.sql

# cowsay
echo "#!/bin/sh" > /etc/update-motd.d/40-cow
echo 'cowsay "Amazon Linux 2 AMI - Animals4Life"' > /etc/update-motd.d/40-cow
chmod 755 /etc/update-motd.d/40-cow
update-motd

