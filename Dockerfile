FROM alpine:3.12

# Install Go
ARG GO_VERSION="1.15.6"
ARG USERNAME="vscode"
    
# Create User
RUN addgroup --gid 1000 $USERNAME && \
    adduser -s /bin/zsh -u 1000 -D -G $USERNAME $USERNAME

# Install some additional packages
RUN apk update && \
    apk add --no-cache zsh=~5.8-r1 zsh-vcs=~5.8-r1 git=~2.26.2-r0 curl=~7.69.1-r3

# Install Go
RUN apk add --no-cache --virtual .build-deps bash gcc musl-dev openssl go && \
    curl https://dl.google.com/go/go${GO_VERSION}.src.tar.gz --output go.src.tar.gz && \
    tar -C /usr/local -xzf go.src.tar.gz && \
    cd /usr/local/go/src/ && \
    ./make.bash && \
    apk del .build-deps

# Install oh-my-zsh
RUN curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output install.sh && \
    sh ./install.sh && \
    cp -r /root/.oh-my-zsh /home/vscode/.oh-my-zsh && \
    chown -R $USERNAME:$USERNAME /home/vscode/.oh-my-zsh && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/vscode/.oh-my-zsh/custom/themes/powerlevel10k
