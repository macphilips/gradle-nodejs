FROM gradle:5.0-jdk8-alpine

LABEL application="gradle-node"

ENV NODE_VERSION 11.6.0
USER root

RUN \
apt-get update && \
# install utilities
apt-get install -y \
wget \
curl \
vim \
git \
zip \
bzip2 \
fontconfig \
python \
g++ \
libpng-dev \
build-essential && \
# install node.js
wget https://nodejs.org/dist/v11.6.0/node-v11.6.0-linux-x64.tar.gz -O /tmp/node.tar.gz && \
tar -C /usr/local --strip-components 1 -xzf /tmp/node.tar.gz && \
# upgrade npm
npm install -g npm && \
# install yarn
npm install -g yarn && \
# su -c "yarn config set prefix /home/jhipster/.yarn-global" jhipster && \
# install yeoman
# npm install -g yo && \
# cleanup
apt-get clean && \
rm -rf \
# /home/jhipster/.cache/ \
/var/lib/apt/lists/* \
/tmp/* \
/var/tmp/*

USER gradle

RUN set -o errexit -o nounset \
    && echo "Testing Gradle-NodeJS installation" \
    && gradle --version \
    && node --version \
    && npm --version \
    && yarn --version
