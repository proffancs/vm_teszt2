#!/bin/bash

VERSION_NODE="14"
VERSION_ANGULAR="13"
VERSION_JDK="17"
VERSION_MAVEN="3.8.5"
URL_MAVEN="https://dlcdn.apache.org/maven/maven-3/${VERSION_MAVEN}/binaries"

echo "...OTP EBIZ COMMON IMAGEBUILDER... update"
apt-get update -y
echo "...OTP EBIZ COMMON IMAGEBUILDER... install & configure packages"
apt-get install -y \
    apt apt-utils apt-transport-https ca-certificates software-properties-common sudo gnupg jq \
    curl wget git netcat-openbsd file lsb-release debconf-i18n gnupg-agent aufs-tools cgroupfs-mount cgroup-lite \
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
echo "...OTP EBIZ COMMON IMAGEBUILDER... install docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
echo "...OTP EBIZ COMMON IMAGEBUILDER... install nodejs, npm"
curl -sL https://deb.nodesource.com/setup_${VERSION_NODE}.x | bash -
apt-get install -y nodejs
echo "...OTP EBIZ COMMON IMAGEBUILDER... install angular"
echo N | npm install -g @angular/cli@${VERSION_ANGULAR}
echo "...OTP EBIZ COMMON IMAGEBUILDER... install java"
apt-get install -y openjdk-${VERSION_JDK}-jdk
echo "...OTP EBIZ COMMON IMAGEBUILDER... install maven"
mkdir -p /usr/share/maven /usr/share/maven/ref
curl -fsSL -o /tmp/apache-maven.tar.gz ${URL_MAVEN}/apache-maven-${VERSION_MAVEN}-bin.tar.gz
tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1
rm -f /tmp/apache-maven.tar.gz
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
echo "...OTP EBIZ COMMON IMAGEBUILDER... checking versions"
echo "...kubectl version"
kubectl version --client
echo "...helm version"
helm version
echo "...azure cli version"
az --version
echo "...kubelogin version"
kubelogin --version
echo "...azcopy version"
azcopy --version
echo "...github cli version"
gh --version
echo "...ng version"
ng --version
echo "...npm version"
npm --version
echo "...nodejs version"
node -v
echo "...java version"
java -version
echo "...maven version"
mvn -version
echo "...docker version"
docker version
echo "...docker test run"
docker run hello-world
