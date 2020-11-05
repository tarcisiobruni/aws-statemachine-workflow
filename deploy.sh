#!/bin/bash

: "${STACK_NAME:=$1}"
: "${S3_BUCKET:=$2}"
: "${PROFILE:=$3}"

if [[ -z ${STACK_NAME} ]] ; then
  echo "No stackname was provided."
  echo "Use: sh deploy.sh <STACK_NAME> <S3_BUCKET> <PROFILE>"
  exit 2
fi

if [[ -z ${S3_BUCKET} ]] ; then
  echo "No s3 bucket was provided."
  echo "Use: sh deploy.sh <STACK_NAME> <S3_BUCKET> <PROFILE>"
  exit 2
fi

if [[ -z ${PROFILE} ]] ; then
  echo "No profie was provided."
  echo "Use: sh deploy.sh <STACK_NAME> <S3_BUCKET> <PROFILE>"
  exit 2
fi

# FILENAME=$(echo $RANDOM.${STACK_NAME} | openssl dgst -sha1 | sed 's/^.* //')
# S3_OPEN_API="s3://$S3_BUCKET/$STACK_NAME/$FILENAME"

# aws s3 cp openapi.yaml ${S3_OPEN_API} --sse

# echo '...cleaning distribution folder'
# rm -rf dist && mkdir dist

# echo '...building production source code node_modules'
# rm -rf node_modules && npm install && tsc

# sam package --output-template-file packaged.yaml --template-file cloudformation.yaml --s3-bucket ${S3_BUCKET}
# sam deploy --template-file packaged.yaml --capabilities CAPABILITY_NAMED_IAM --stack-name ${STACK_NAME} \
#   --parameter-overrides OpenAPIS3File=${S3_OPEN_API}

# exit 0

# sam package --output-template-file packaged.yaml --template-file template.yaml --s3-bucket ${S3_BUCKET} --profile ${PROFILE}
# sam deploy --region us-east-1 --template-file packaged.yaml --capabilities CAPABILITY_NAMED_IAM --stack-name ${STACK_NAME} --profile ${PROFILE}

aws s3 cp openapi.yaml s3://api-statemachine-bucket/api-state-stack/openapi.yaml --sse --profile personal
sam package --output-template-file packaged.yaml --template-file template.yaml --s3-bucket api-statemachine-bucket --profile personal
sam deploy --region us-east-1 --template-file packaged.yaml --capabilities CAPABILITY_NAMED_IAM --stack-name api-state-stack --parameter-overrides OpenAPIS3File=s3://api-statemachine-bucket/api-state-stack/openapi.yaml --profile personal
aws cloudformation delete-stack --stack-name api-state-stack --profile personal --region us-east-1
