#!/bin/bash

vpcid=$(aws ec2 describe-instances --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) | jq .Reservations[0].Instances[0].VpcId -r)
instances=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcid" | jq -M .Reservations[0].Instances)

echo $instances 
#echo $(echo $instances | jq length -r)

exit 0

COUNTER=0
while [  $COUNTER -lt $(echo $instances | jq length -r) ]; do
    echo The counter is $COUNTER
    let COUNTER=COUNTER+1 
done
echo "VPCID: $vpcid"
