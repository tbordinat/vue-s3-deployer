#!/usr/bin/env bash

#Move to app source code
cd $INPUT_APP_SOURCE_CODE

#Install dependencies
echo "Installing dependencies"
npm config set //registry.npmjs.org/:_authToken=$INPUT_NPM_TOKEN
npm install > /dev/null 2>&1

#Build application
echo "Building application"

#Execute the command provided
`echo $INPUT_BUILD_COMMAND` 

#Sync files with amazon s3 bucket app
aws --region $INPUT_AWS_DEFAULT_REGION s3 sync ./dist s3://$INPUT_AWS_BUCKET_NAME --no-progress --delete
