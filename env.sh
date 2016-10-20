#!/bin/bash

installDotnetUbuntu14orMint17(){
    sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
    sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
    sudo apt-get update
    sudo apt-get install dotnet-dev-1.0.0-preview2-003131
}

installDotnetUbuntu16(){
    sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
    sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
    sudo apt-get update
    sudo apt-get install dotnet-dev-1.0.0-preview2-003131
}

installDotnetDebian8(){
    sudo apt-get update && sudo apt-get install git-core
    sudo apt-get install curl libunwind8 gettext
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=827530
    sudo mkdir -p /opt/dotnet && sudo tar zxf dotnet.tar.gz -C /opt/dotnet
    sudo ln -s /opt/dotnet/dotnet /usr/local/bin
}


installDocker(){
    sudo curl -sSL https://get.docker.com/ | sh
}





# Runs docker-compose.
setupEnv () {
  echo "Setting up Environment for $ENVIRONMENT...."

#   if [[ -z $ENVIRONMENT ]]; then
#     ENVIRONMENT="debian"
#   fi

#   case "$ENVIRONMENT" in
#     "debian" )
#         echo "Installing .NET SDK...."
#         installDotnetDebian8
#         echo "Installing Docker...."
#         installDocker
#         reboot
#         ;;
#     "ubuntu" )
#         installDotnetUbuntu16
#         echo "Installing Docker...."
#         installDocker
#         reboot
#   esac
}


# Shows the usage for the script.
showUsage () {
  echo "Usage: env.sh (ENVIRONMENT) "
  echo "    Sets up a environment for ignite (if not provided, debian environment is used)"
  echo ""
  echo "Environment Platform:"
  echo "    mac: Sets environment for a macOS."
  echo "    ubuntu: Sets environment for Ubuntu 16 distro. Reboots system automatically."
  echo "    ubuntu14: Sets environment for Ubuntu 14 based distro. Reboots system automatically."
  echo "    mint: Sets environment for Mint 17 distro. Reboots system automatically."
  echo "    debian: Sets environment for Debian 8 distro. Reboots system automatically."
  echo ""
  echo "Example:"
  echo "    ./env.sh ubuntu"
  echo ""
}

if [ $# -eq 0 ]; then
  showUsage
else
    ENVIRONMENT=$(echo $1 | tr "[:upper:]" "[:lower:]")
    setupEnv
fi
