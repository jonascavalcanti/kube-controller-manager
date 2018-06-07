# Controller Manager v1.9.8
# Kubernetes

<img src="https://github.com/kubernetes/kubernetes/raw/master/logo/logo.png" width="100">

----

Kubernetes is an open source system for managing [containerized applications]
across multiple hosts; providing basic mechanisms for deployment, maintenance,
and scaling of applications.

Kubernetes builds upon a decade and a half of experience at Google running
production workloads at scale using a system called [Borg],
combined with best-of-breed ideas and practices from the community.

Kubernetes is hosted by the Cloud Native Computing Foundation ([CNCF]).
If you are a company that wants to help shape the evolution of
technologies that are container-packaged, dynamically-scheduled
and microservices-oriented, consider joining the CNCF.
For details about who's involved and how Kubernetes plays a role,
read the CNCF [announcement].

----

# Environment Variables Defaults

```
KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
CLUSTER_NAME="cluster.local"
PATH_BASE_KUBERNETES="/opt/kubernetes"
DIR_CERTS="${PATH_BASE_KUBERNETES}/certificates"
CONTROLLER_MANAGER_CERTS="${DIR_CERTS}/kube-controller-manager"
CONTROLLER_MANAGER_PEM="kube-controller-manager.pem"
CONTROLLER_MANAGER_KEY_PEM="kube-controller-manager-key.pem"
CA_CERT_PEM="ca.pem"
CA_CERT_PEM_KEY="ca-key.pem"
API_KEY_PEM="apiserver-key.pem"

```

# How to use this image

Start with docker command

```
docker run -d 
        --name <container_name> \
        --privileged \
        -p 10252:10252 \  
        -e KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
        -e CLUSTER_NAME="cluster.local"
        -e PATH_BASE_KUBERNETES="/opt/kubernetes/kube-controller-manager"
        -e DIR_CERTS="${PATH_BASE_KUBERNETES}/certificates"
        -e CONTROLLER_MANAGER_CERTS="${DIR_CERTS}/kube-controller-manager"
        -e CONTROLLER_MANAGER_PEM="kube-controller-manager.pem"
        -e CONTROLLER_MANAGER_KEY_PEM="kube-controller-manager-key.pem"
        -e CA_CERT_PEM="ca.pem"
        -e CA_CERT_PEM_KEY="ca-key.pem"
        -e API_KEY_PEM="apiserver-key.pem"
        -v <path_local_storage_with_certificates_api>:${DIR_CERTS} <image>:<tag>
```

# Docker example

```
docker run -d \
    --name kube-controller-manager \
    --privileged \
    -p 10252:10252  \
    -v /opt/kubernetes/certificates/services:/opt/kubernetes/certificates \
    kube-controller-manager:latest
```
