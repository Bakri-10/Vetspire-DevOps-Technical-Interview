#!/bin/bash

arch=$(dpkg --print-architecture)

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$arch/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# install kubeconform
curl -L https://github.com/yannh/kubeconform/releases/latest/download/kubeconform-linux-$arch.tar.gz | tar xvzf - && \
sudo mv kubeconform /usr/local/bin/

# install docker
curl -L https://download.docker.com/linux/static/stable/$(uname -m)/docker-25.0.1.tgz | tar xvzf - && \
sudo cp docker/* /usr/bin/ && \
sudo dockerd &
