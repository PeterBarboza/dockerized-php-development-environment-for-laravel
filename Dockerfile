FROM ubuntu:22.04

ARG BUILD_NVM_VERSION=v0.40.1
ARG BUILD_NODEJS_VERSION=v22.12.0
ARG BUILD_PHP_VERSION=8.4

USER root
WORKDIR /root

ENV TERM=xterm
ENV NVM_DIR=/root/.nvm

RUN apt update && apt install -y curl

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$BUILD_NVM_VERSION/install.sh | bash && \ 
  [ -s "$NVM_DIR/nvm.sh" ] && \
  \. "$NVM_DIR/nvm.sh" && \
  nvm install $BUILD_NODEJS_VERSION && \
  nvm alias default $BUILD_NODEJS_VERSION

ENV NODE_PATH $NVM_DIR/$BUILD_NODEJS_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/$BUILD_NODEJS_VERSION/bin:$PATH

RUN /bin/bash -c "$(curl -fsSL https://php.new/install/linux/$BUILD_PHP_VERSION)"

WORKDIR /root/workspace

CMD ["tail", "-f", "/dev/null"]
