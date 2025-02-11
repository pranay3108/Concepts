#!/bin/bash
#Please Configure aws first
aws s3 ls

#Installing Ansible on Master Machine
sudo apt update  -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
ansible --version

#Installing Java JDK for Jenkins
sudo apt update  -y
sudo apt install fontconfig openjdk-17-jre -y
java -version

#Installing Jenkins on Master Machine
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install jenkins -y

#Installing Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release  -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install trivy -y
trivy -v

#Installing Kube CTL
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client

#Installing EKS CTL
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
eksctl version

#Installing Docker on Master Machine
sudo apt-get update  -y
sudo apt-get install docker.io docker-compose-v2 -y
sudo usermod -aG docker $USER && newgrp docker
docker --version


#Installing SonarQube
docker run -itd --name SonarQube-Server -p 9000:9000 sonarqube:lts-community



#Creating Cluster
#Checking Jenkins
sudo systemctl status jenkins







