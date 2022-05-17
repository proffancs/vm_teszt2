#!/bin/bash

set -e

echo "...update"
apt-get update -y
#apt-get upgrade -y
echo "...install & configure packages"
apt-get install -y \
    apt-utils apt-transport-https ca-certificates software-properties-common build-essential sudo gnupg \
    curl wget jq git iputils-ping netcat netcat-openbsd zip unzip file gcc lsb-release \
    gnupg-utils gpg openssl readline-common less libcurl4 libssl1.1 libffi7 jq \
    software-properties-common debconf-utils dos2unix \
    libunwind8 libicu66 tzdata python-is-python3 python3-pip \
    locales language-pack-hu language-pack-en language-pack-en-base language-pack-hu-base fonts-dejavu ttf-dejavu
#echo "Europe/Budapest" > /etc/timezone && \
#ln -fs /usr/share/zoneinfo/Europe/Budapest /etc/localtime && \
#dpkg-reconfigure --frontend noninteractive tzdata && \
#update-ca-certificates && \
#locale-gen en_US.UTF-8 && \
#update-locale LANG=en_US.UTF-8 && \
#update-locale LC_ALL=en_US.UTF-8 && \
#echo "...install kube*" && \
#curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
#echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
#apt-get update -y && \
#apt-get install -y kubelet kubeadm kubectl && \
#echo "...install helm" && \
#curl https://baltocdn.com/helm/signing.asc | sudo apt-key add - && \
#echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
#apt-get update -y && \
#apt-get install -y helm && \
#echo "...install azure cli..." && \
#curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
#echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ focal main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && \
#apt-get update -y && \
#apt-get install -y azure-cli && \
#echo "...install kubelogin" && \
#az aks install-cli && \
#echo "...add azure cli extensions" && \
#az extension add --name azure-devops && \
#az extension add --name application-insights && \
#az extension add --name aks-preview && \
#az extension add --name k8s-extension && \
#az extension add --name log-analytics && \
#echo "...install azcopy" && \
#mkdir -p azcopy && \
#cd azcopy && \
#wget https://aka.ms/downloadazcopy-v10-linux && \
#tar -xvf downloadazcopy-v10-linux && \
#cp azcopy_linux_amd64_*/azcopy /usr/bin/ && \
#cd .. && \
#rm -rf azcopy && \
#echo "...install github cli" && \
#curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
#apt-get update -y && \
#apt-get install -y gh
