#!/bin/bash

subnetid=$(aws ec2 describe-instances --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) | jq .Reservations[0].Instances[0].SubnetId -r)
gname=$(sh -c "aws autoscaling describe-auto-scaling-groups | jq '.AutoScalingGroups | map(select(.VPCZoneIdentifier == \"$subnetid\")) | .[0].AutoScalingGroupName' -r")
echo $gname
