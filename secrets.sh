#!/bin/bash
AWS_ACCOUNT=437624294127     # custom script | your aws account id  
AWS_REGION=us-east-2      # custom script | your aws account region of choice 

kubectl create secret docker-registry regcred \
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password) \
  --namespace=monitoring