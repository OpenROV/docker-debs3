FROM debian:wheezy
MAINTAINER OpenROV Inc - Dominik Fretz, dominik@openrov.com
ENV HOME /root

RUN apt-get update && apt-get install -y \
  ruby1.9.3 \
  rubygems \
  gnupg \
  gnupg-agent \
  dpkg-sig \
  git \
  libxml2 \
  libxml2-dev \
  libxslt-dev

RUN gem install bundler

WORKDIR /tmp
RUN git clone https://github.com/krobertson/deb-s3.git

WORKDIR /tmp/deb-s3
RUN git checkout 67c2e65bc94426370137a284001f636ff708b102 && bundle install

ENTRYPOINT ["deb-s3"]
CMD
