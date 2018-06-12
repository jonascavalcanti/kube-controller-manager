FROM centos:7.4.1708
LABEL MAINTAINER="unisp <cicero.gadelha@funceme.br | jonas.cavalcantineto@funceme.com>"

RUN yum update -y 
RUN yum install -y \
            vim \
            wget \
            epel-release.noarch \
            openssl 

RUN yum update -y
RUN yum install -y supervisor.noarch                 

#ENVIRONMENTS
ENV KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
ENV CLUSTER_NAME="cluster.local"
ENV PATH_BASE_KUBERNETES="/opt/kubernetes"
ENV DIR_CERTS="${PATH_BASE_KUBERNETES}/certs"
ENV DIR_CERTS_API="${PATH_BASE_KUBERNETES}/certs/api"
ENV CONTROLLER_MANAGER_CERTS="${DIR_CERTS}/modules/kube-controller-manager"
ENV CONTROLLER_MANAGER_PEM="kube-controller-manager.pem"
ENV CONTROLLER_MANAGER_KEY_PEM="kube-controller-manager-key.pem"
ENV CA_CERT_PEM="ca.pem"
ENV CA_CERT_PEM_KEY="ca-key.pem"
ENV API_KEY_PEM="apiserver-key.pem"


#KUBERNETES
ENV KUBERNETES_VERSION "v1.9.8"

RUN set -ex \
	&& wget https://github.com/kubernetes/kubernetes/releases/download/${KUBERNETES_VERSION}/kubernetes.tar.gz \
 	&& tar -zxvf kubernetes.tar.gz -C /tmp \
 	&& echo y | /tmp/kubernetes/cluster/get-kube-binaries.sh \
 	&& tar -zxvf /tmp/kubernetes/server/kubernetes-server-*.tar.gz -C /tmp/kubernetes/server \
 	&& mkdir -p ${PATH_BASE_KUBERNETES}/bin \
    && cp -a /tmp/kubernetes/server/kubernetes/server/bin/kube-controller-manager ${PATH_BASE_KUBERNETES}/bin/ \
    && ln -s ${PATH_BASE_KUBERNETES}/bin/kube-controller-manager /usr/local/sbin/kube-controller-manager \
    && mkdir -p ${DIR_CERTS} \
	&& useradd kube \
	&& chown -R kube:kube ${PATH_BASE_KUBERNETES}/ \
 	&& rm -rf /tmp/kubernetes \
	&& rm -f kubernetes.tar.gz

ADD bin/start_controller_manager.sh /start_controller_manager.sh
RUN chmod +x /start_controller_manager.sh
#PORTS
# TCP     10252       kube-controller-manager
EXPOSE 10252

COPY conf/supervisord.conf /etc/
ADD bin/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["./start.sh"]
