#!/bin/bash
set -e
set -o pipefail

AWS_EB_APP_NAME="test_travis_ci"
AWS_EB_APP_ENV="TestTravisCi-env"
AWS_REGION="ap-northeast-1"

VERSION=$1
EB_BUCKET="elasticbeanstalk-ap-northeast-1-889231634371"

if [ "$VERSION" == "" ]; then
    echo "ERROR: No version label."
    return 1
fi

echo ">>> Update Dockerrun.aws.json"
cp travis/Dockerrun.aws.json .
ls
sed -i='' "s/<AWS_ECR_REGISTRY>/$AWS_ECR_REGISTRY/" Dockerrun.aws.json
sed -i='' "s/<AWS_ECR_REPO_TEST>/$AWS_ECR_REPO_TEST/" Dockerrun.aws.json
ARTIFACT="Dockerrun.aws.json"

echo ">>> Zip and upload Dockerrun file"
aws s3 cp $ARTIFACT s3://$EB_BUCKET/$ARTIFACT

echo ">>> Create a new app version"
aws elasticbeanstalk create-application-version \
    --region $AWS_REGION \
    --application-name $AWS_EB_APP_NAME \
    --version-label $VERSION \
    --source-bundle S3Bucket=$EB_BUCKET,S3Key=$ARTIFACT

echo ">>> Update app environment"
aws elasticbeanstalk update-environment \
    --region $AWS_REGION \
    --environment-name $AWS_EB_APP_ENV \
    --version-label $VERSION
