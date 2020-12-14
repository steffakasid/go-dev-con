FROM alpine:3.12

USER root
# Install Go
ARG GO_VERSION="1.15.6"
ARG USERNAME="vscode"
    
# Copy setup.sh and run it
COPY setup.sh /opt/setup.sh
RUN /opt/setup.sh ${GO_VERSION} ${USERNAME}