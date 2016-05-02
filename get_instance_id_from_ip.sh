#!/bin/bash

ip=$1

current_instance=$(curl -s http://instance-data/latest/dynamic/instance-identity/document | jq .instanceId -r)
vpcid=$(aws ec2 describe-instances --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) | jq .Reservations[0].Instances[0].VpcId -r)
instance_id=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcid" "Name=network-interface.addresses.private-ip-address,Values=$ip" | jq .Reservations[0].Instances[0].InstanceId -r)
echo $instance_id
