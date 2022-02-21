# Global Clusters configurations

The followed repo contains the bootstrapping proccess for a new RHACM cluster, integrating ArgoCD with RHACM and creating all the needed ApplicationSets to ensure all configurations and apps running in all the RHACM managed clusters.

# Pre-requisites

- A deployed Red Hat Advanced Cluster Management for Kubernetes.
- Red Hat GitOps Operator (this step, also can be bootstrapped)
- CLI access to the RHACM cluster.
- RBAC access to create some resources, as:
  - ArgoCD instance
  - ManagedClusterSet
  - ManagedClusterSetBinding
  - Placement
  - GitOpsCluster

# Manual steps

We try to make only one manual step. The creation of the needed resources to create an ArgoCD instance and intregrate it with RHACM.

After this manual step, ArgoCD via an ApplicationSet are going to create all the needed Applications that includes all the configurations.

## Hands-On

````bash
oc apply -f bootstrap/.

Your ArgoCD route

oc get route -n openshift-gitops

Your Admin Password

oc extract secret/openshift-gitops-cluster --to=- -n openshift-gitops
````
