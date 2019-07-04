#!/bin/bash

AWS_EB_APP_NAME="test_travis_ci"
AWS_EB_APP_ENV="TestTravisCi-env"
VERSION=$1
EB_BUCKET="elasticbeanstalk-ap-northeast-1-889231634371"
# ZIP="$AWS_EB_APP_NAME.$VERSION.zip"
ZIP="Dockerrun.aws.json"

echo "Zip and upload Dockerrun file"
#zip -r $ZIP . -i Dockerrun.aws.json
pwd
aws s3 cp $ZIP s3://$EB_BUCKET/$ZIP

echo "Create a new app version"
aws elasticbeanstalk create-application-version \
    --region ap-northeast-1 \
    --application-name $AWS_EB_APP_NAME \
    --version-label $VERSION \
    --source-bundle S3Bucket=$EB_BUCKET,S3Key=$ZIP

echo "Update app environment"
aws elasticbeanstalk update-environment \
    --region ap-northeast-1 \
    --environment-name $AWS_EB_APP_ENV \
    --version-label $VERSION
