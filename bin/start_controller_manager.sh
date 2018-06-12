#!/bin/bash

 kube-controller-manager \
--v=2 \
--allocate-node-cidrs=true \
--attach-detach-reconcile-sync-period=1m0s \
--cluster-cidr=${KUBERNETES_CLUSTER_RANGE_IP} \
--cluster-name=${CLUSTER_NAME} \
--leader-elect=true \
--root-ca-file=${DIR_CERTS_API}/${CA_CERT_PEM} \
--service-account-private-key-file=${DIR_CERTS_API}/${API_KEY_PEM} \
--use-service-account-credentials=true \
--kubeconfig=${CONTROLLER_MANAGER_CERTS}/kubeconfig \
--cluster-signing-cert-file=${CONTROLLER_MANAGER_CERTS}/${CONTROLLER_MANAGER_PEM} \
--cluster-signing-key-file=${CONTROLLER_MANAGER_CERTS}/${CONTROLLER_MANAGER_KEY_PEM} \
--service-cluster-ip-range=${KUBERNETES_CLUSTER_RANGE_IP}  \
--configure-cloud-routes=false

