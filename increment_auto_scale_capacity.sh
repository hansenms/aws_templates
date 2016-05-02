#!/bin/bash

increment=$1
gname=$(sh ./get_auto_scaling_group_name.sh)
current_capacity=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name=${gname}| jq .AutoScalingGroups[0].DesiredCapacity)
new_capacity=`expr $current_capacity + $increment`
aws autoscaling set-desired-capacity --auto-scaling-group-name=$gname  --desired-capacity $new_capacity
