#!/bin/bash

COMPONENT="${1}"
SERVICE="${2}"
VERSION="${3}"
ENVIRON="test"
BUILD_DIR="ops/"
TPL_FILE="packer/template.json"
INSTANCE_TYPE="t2.small"
CONSUL_MASTER=$(aws ec2 describe-instances --filters 'Name=instance-state-name,Values=running' 'Name=tag:environment,Values=prod' \
'Name=tag:service,Values=master' 'Name=tag:component,Values=consul' --query='Reservations[*].Instances[*].NetworkInterfaces[*].[PrivateIpAddress]' --output text)

## Deps
which packer > /dev/null
if [[ $? -ne 0 ]]; then
  echo "--> Packer not found. Installing Packer..."
  curl -LOs https://dl.bintray.com/mitchellh/packer/packer_0.8.6_darwin_amd64.zip
  unzip packer*.zip
  rm -f packer*.zip
  sudo mv packer* /usr/local/bin/
fi

## AMI change
## Own images
case "${SERVICE}" in
  'api')
    AMI_ID="ami-190dc572"
    ;;
  'worker')
    AMI_ID="ami-63f83608"
    ;;
esac

## Switch directory
cd "${BUILD_DIR}"

## Build image
packer build \
  -var "aws_ami_id=${AMI_ID}" \
  -var "ansible_playbook=ansible/playbook/${COMPONENT}/${SERVICE}.yml" \
  -var "build_ami_name=${COMPONENT}-${SERVICE}-${VERSION}" \
  -var "instance_type=${INSTANCE_TYPE}" \
  -var "environ=${ENVIRON}" \
  -var "component=${COMPONENT}" \
  -var "service=${SERVICE}" \
  -var "consul_master=${CONSUL_MASTER}" \
  "${TPL_FILE}"
