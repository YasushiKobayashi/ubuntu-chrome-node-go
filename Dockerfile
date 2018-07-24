FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y curl wget git unzip build-essential gcc zlib1g-dev libssl-dev language-pack-ja-base language-pack-en && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# setup lang ja
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# setup nodejs
ENV NODE_V=v8.9.4
ENV PATH=/usr/local/node-${NODE_V}-linux-x64/bin:$PATH
WORKDIR /usr/local
RUN wget https://nodejs.org/download/release/${NODE_V}/node-${NODE_V}-linux-x64.tar.gz && \
  tar -zxvf node-${NODE_V}-linux-x64.tar.gz
RUN npm i -g yarn

# setup golang
WORKDIR /usr/local
ENV GO_V=1.10
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget https://storage.googleapis.com/golang/go${GO_V}.linux-amd64.tar.gz && \
  tar -zxvf go${GO_V}.linux-amd64.tar.gz

# setup python
WORKDIR /root/
RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz && \
  tar zxf Python-3.6.0.tgz && \
  cd Python-3.6.0 && \
  ./configure && \
  make altinstall
ENV PYTHONIOENCODING "utf-8"
RUN pip3.6 install selenium && \
  pip3.6 install faker

