#!/bin/bash

NAME=sagemaker

# Create container

echo -e "\n## Create $NAME container\n"

toolbox rm --force $NAME || true
toolbox create --container $NAME

# Install applications

echo -e "\n## Install $NAME tools and applications\n"

RUN="toolbox run --container $NAME"

## Terraform Prerequisites

$RUN sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

## List of applications to be installed

APPLICATIONS=( terraform )

## Install applications

echo "### Installing applications:"
for app in ${APPLICATIONS[@]}; do
  echo -e "\n--- Installing $app ---\n";
  $RUN sudo dnf install -y $app;
  echo -e "\n--- $app installed ---\n";
done

## Install awscli

$RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
$RUN unzip /tmp/awscliv2.zip -d /tmp
$RUN sudo /tmp/aws/install

## Link `podman` to local host binaries
$RUN sudo bash -c 'echo -e "\
alias docker='\''flatpak-spawn --host /usr/bin/podman'\'' \n\
alias docker-compose='\''flatpak-spawn --host /usr/bin/podman-compose'\'' \n\
alias podman='\''flatpak-spawn --host /usr/bin/podman'\'' "\
> /etc/profile.d/podman.sh'

# Exit after installation

echo -e "\n## Completed installation of:\n"
for app in $APPLICATIONS; do
  echo "--- $app";
done
