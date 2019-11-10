FROM ruby:2.6-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev
RUN apt-get install -qq -y libsqlite3-dev
RUN apt-get update && apt-get install -qq -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -qq -y yarn

ENV INSTALL_PATH /vue_example

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile.lock /$INSTALL_PATH/Gemfile.lock
COPY Gemfile ./

ENV BUNDLE_PATH /box

COPY . /$INSTALL_PATH