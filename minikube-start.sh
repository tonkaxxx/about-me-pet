#!/bin/bash

kubectl apply -f k8s/mongo-secret.yaml
kubectl apply -f k8s/mongo-config.yaml
kubectl apply -f k8s/mongo.yaml
kubectl apply -f k8s/webapp.yaml
