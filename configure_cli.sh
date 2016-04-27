#!/bin/bash

aws configure set region $(curl -s http://instance-data/latest/dynamic/instance-identity/document | jq .region -r)
