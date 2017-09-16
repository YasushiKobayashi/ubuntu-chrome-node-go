FROM python:3.6-jessie
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

RUN apt-get update
RUN apt-get install -y curl wget

# setup chrome
RUN set -x && \
  apt-get install -y chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser

# setup nodejs
ENV NODE_V=v8.1.0
ENV PATH=/usr/local/node-${NODE_V}-linux-x64/bin:$PATH
WORKDIR /usr/local
RUN wget https://nodejs.org/download/release/${NODE_V}/node-${NODE_V}-linux-x64.tar.gz && \
  tar -zxvf node-${NODE_V}-linux-x64.tar.gz
RUN which node
RUN ls -la /usr/local/bin
RUN node -v && npm -v


# setup golang glide
WORKDIR /usr/local
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz && \
  tar -zxvf go1.8.3.linux-amd64.tar.gz && \
  mkdir -p $GOPATH/bin && \
  curl https://glide.sh/get | sh

# setup python selenium
RUN pip install selenium
