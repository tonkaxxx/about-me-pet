#!/bin/bash
cd k8s
export $(grep -v '^#' .env | xargs)
cd ..
envsubst < k8s/mongo-secret.template.yaml > k8s/mongo-secret.yaml

kubectl apply -f k8s/mongo-secret.yaml
kubectl apply -f k8s/mongo-config.yaml
kubectl apply -f k8s/mongo.yaml
kubectl apply -f k8s/webapp.yaml
