FROM gradle:5.0-jdk8-alpine

LABEL application="gradle-node"

ENV NODE_VERSION 11.6.0
ENV NODE_HOME "/opt/node-${NODE_VERSION}"
USER root

RUN apk add nodejs

RUN echo "Updating NPM Package" &&  \
npm install -g npm && \
npm install -g yarn

USER gradle

RUN set -o errexit -o nounset \
    && echo "Testing Gradle-NodeJS installation" \
    && gradle --version \
    && node --version \
    && npm --version \
    && yarn --version
