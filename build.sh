#!/usr/bin/env bash

###
### Variables
###
Image="sagemaker-sklearn-example"
Region="us-east-1"

###
### Main
###

# check repository existence for the image
aws ecr describe-repositories --repository-names "${Image}" --region ${Region} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Create repository for ${Image} in ${Region}"
    aws ecr create-repository --repository-name "${Image}" --region ${Region}
fi

# build and push the image
AWSAccount=$(aws sts get-caller-identity --query Account --output text)
ECRPath="${AWSAccount}.dkr.ecr.${Region}.amazonaws.com/${Image}:latest"
$(aws ecr get-login --region ${Region} --no-include-email)

docker build  -t ${Image} .
docker tag ${Image} ${ECRPath}
docker push ${ECRPath}
