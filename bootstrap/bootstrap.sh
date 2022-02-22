#!/bin/bash

oc apply -f bootstrap/argocd-instance.yaml

while [[ $( oc get pods -l  app.kubernetes.io/name=openshift-gitops-server -n openshift-gitops -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
   sleep 1
   echo "We are waiting to a Ready ArgoCD instance"
   echo "..."
   sleep 5
done

echo "---------------------------------------------------"
echo "  Integrate ArgoCD with all the managed clusters"
echo "---------------------------------------------------"

oc apply -f bootstrap/managedclusterset.yaml
oc apply -f bootstrap/managedclustersetbinding.yaml
oc apply -f bootstrap/placement.yaml
oc apply -f bootstrap/gitopsserver.yaml


echo "---------------------------------------------------"
echo "       Deploying the App of ApplicationSet"
echo "---------------------------------------------------"

oc apply -f bootstrap/global-config-application.yaml


echo "---------------------------------------------------"
echo "             Your ArgoCD WebUI URL"
echo "---------------------------------------------------"

oc get route -l  app.kubernetes.io/name=openshift-gitops-server -n openshift-gitops -o 'jsonpath={..spec.host}'
echo ""



echo "---------------------------------------------------"
echo "           Your ArgoCD Admin Password"
echo "---------------------------------------------------"

oc extract secret/openshift-gitops-cluster --to=- -n openshift-gitops
