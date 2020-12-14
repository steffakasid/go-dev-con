#!/bin/sh

set -e

GO_VERSION=${1:-"1.15.6"}
USERNAME=${2:-"vscode"}

# Create User
addgroup --gid 1000 $USERNAME
adduser -s /bin/zsh -u 1000 -D -G $USERNAME $USERNAME

# Install some additional packages
apk update
apk add --no-cache zsh=~5.8-r1 git zsh-vcs

apk add --no-cache --virtual .build-deps bash curl gcc musl-dev openssl go

curl https://dl.google.com/go/go${GO_VERSION}.src.tar.gz --output go.src.tar.gz
tar -C /usr/local -xzf go.src.tar.gz
cd /usr/local/go/src/
./make.bash

# Install oh-my-zsh
curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output install.sh
sh ./install.sh && 
    
# cleanup build-deps
apk del .build-deps

cp -r /root/.oh-my-zsh /home/vscode/.oh-my-zsh
chown -R $USERNAME:$USERNAME /home/vscode/.oh-my-zsh