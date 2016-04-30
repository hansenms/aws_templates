#!/bin/bash

current_instance=$(curl -s http://instance-data/latest/dynamic/instance-identity/document | jq .instanceId -r)
vpcid=$(aws ec2 describe-instances --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) | jq .Reservations[0].Instances[0].VpcId -r)
instances=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcid" | jq .Reservations -r)

instance_count=0
reservations=$(echo $instances | jq length)
rev_counter=$reservations
node_status="Node \t| Id \t\t| IP \t\t| Logfile \t\t\t\t\t| Log modified \t\t|\n"
while [ $rev_counter -gt 0 ]; do
    ins=$(echo $instances | jq .[$rev_counter-1])
    ic=$(echo $ins| jq '.Instances | length')
    while [ $ic -gt 0 ]; do
	instance=$(echo $ins | jq .Instances[$ic-1])
	ip=$(echo $instance | jq .PrivateIpAddress -r)
	id=$(echo $instance | jq .InstanceId -r)
	name="ip-$(echo $ip | tr '.' '-')"
	logfile="/gtmount/gtlog/${name}/gadgetron.log"
	LT="MISSING LOG FILE !!"
	if [ -e "$logfile" ]; then
	    LT=$(tac $logfile | grep -m1 -oP '(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})')
	fi
	node_idx=$instance_count
	if [ "$id" = "$current_instance" ]; then
	    node_idx="${node_idx}*"
	fi
	node_status="${node_status}${node_idx} \t|$id\t|$ip\t| $logfile \t| $LT \t|\n"
	instance_count=`expr $instance_count + 1`
	ic=`expr $ic - 1`
    done
    rev_counter=`expr $rev_counter - 1`
done

echo "VPCID: $vpcid"
echo "Number of nodes: $instance_count"
echo $node_status

exit 0

