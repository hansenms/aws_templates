#!/bin/bash

capacity=$1
gname=$(sh ./get_auto_scaling_group_name.sh)
aws autoscaling set-desired-capacity --auto-scaling-group-name=$gname  --desired-capacity $capacity
