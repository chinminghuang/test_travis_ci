#!/bin/bash

APP_NAME="test_travis_ci"
VERSION=$1
EB_BUCKET="elasticbeanstalk-ap-northeast-1-889231634371"
ZIP=$VERSION.zip

echo "Create a new app version"
aws elasticbeanstalk create-application-version \
    --application-name $APP_NAME \
    --version-label $VERSION \
    --source-bundle S3Bucket=$EB_BUCKET,S3Key=$ZIP

echo "Update app environment"
aws elasticbeanstalk update-environment \
    --environment-name $APP_NAME \
    --version-label $VERSION
