#!/usr/bin/env bash

mkdir -p ~/.aws

cat > ~/.aws/credentials << END_OF_CREDENTIALS
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
END_OF_CREDENTIALS

cat > ~/.aws/config << END_OF_CONFIG
[default]
region=ap-northeast-1
output=json
END_OF_CONFIG
