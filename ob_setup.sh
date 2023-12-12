#!/bin/zsh

# installing stuff
which -s brew
if [[ $? != 0 ]] ; then
    echo "[-] Homebrew not found on system, installing it now"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "[-] Updating Homebrew"
brew update
echo "[-] Installing hyperkit, minikube, and skaffold"
brew install hyperkit minikube skaffold

# starting Minikube
echo "[-] Starting Minikube"
minikube start --cpus=4 --memory 4096 --disk-size 32g --vm-driver=hyperkit

# setting up Online Boutique
echo "[-] Cloning Google's Online Boutique Demo"
git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
echo "[-] Setting up Google's Online Boutique Demo"
( cd microservices-demo && skaffold run )

# Stopping minikube
minikube stop

echo "Start the Kubernetes environment with -> minikube start"
echo "Frontend is available with the following command on localhost:8080 -> kubectl port-forward deployment/frontend 8080:8080"
