#!/bin/sh

# Install some additional packages
apk update
apk add --no-cache zsh=~5.8-r1

apk add --no-cache --virtual .build-deps curl git gcc musl-dev openssl go

curl https://dl.google.com/go/go${GO_VERSION}.src.tar.gz --output go.src.tar.gz
tar -C /usr/local -xzf go.src.tar.gz
cd /usr/local/go/src/
./make.bash

# Install oh-my-zsh
curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output install.sh
sh ./install.sh && 
    
# cleanup build-deps
apk del .build-deps