#!/bin/bash

#set -e

echo "...OTP EBIZ COMMON IMAGEBUILDER... update"
apt-get update -y
#echo "...OTP EBIZ COMMON IMAGEBUILDER... upgrade"
#apt-get upgrade -y
echo "...OTP EBIZ COMMON IMAGEBUILDER... install & configure packages"
apt-get install -y \
    apt apt-utils apt-transport-https ca-certificates software-properties-common sudo gnupg jq \
    curl wget git netcat-openbsd file lsb-release debconf-i18n \
    gnupg-utils gpg readline-common less libcurl4 software-properties-common libunwind8 locales
echo "...OTP EBIZ COMMON IMAGEBUILDER... update certificates"
update-ca-certificates
echo "...OTP EBIZ COMMON IMAGEBUILDER... install kube*"
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y kubelet kubeadm kubectl
echo "...OTP EBIZ COMMON IMAGEBUILDER... install helm"
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update -y
apt-get install -y helm
echo "...OTP EBIZ COMMON IMAGEBUILDER... install azure cli..."
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
apt-get update -y
apt-get install -y azure-cli
echo "...OTP EBIZ COMMON IMAGEBUILDER... install kubelogin"
az aks install-cli
echo "...OTP EBIZ COMMON IMAGEBUILDER... add azure cli extensions"
az extension add --name azure-devops
az extension add --name application-insights
az extension add --name aks-preview
az extension add --name k8s-extension
az extension add --name log-analytics
echo "...OTP EBIZ COMMON IMAGEBUILDER... install azcopy"
mkdir -p azcopy
cd azcopy
wget https://aka.ms/downloadazcopy-v10-linux
tar -xvf downloadazcopy-v10-linux
cp azcopy_linux_amd64_*/azcopy /usr/bin/
cd ..
rm -rf azcopy
chmod gou+x /usr/bin/azcopy
echo "...OTP EBIZ COMMON IMAGEBUILDER... install github cli"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt-get update -y
apt-get install -y gh
echo "...OTP EBIZ COMMON IMAGEBUILDER... checking versions"
echo "...kubectl"
kubectl version --client
echo "...helm"
helm version
echo "...azure cli"
az --version
echo "...kubelogin"
kubelogin --version
echo "...azcopy"
azcopy --version
echo "...github cli"
gh --version
