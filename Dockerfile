FROM ruby:3.0-alpine

ARG BUNDLE_WITHOUT="development:test"
ARG BUNDLE_GITHUB__COM=""

ENV APP_HOME=/usr/src/app

RUN mkdir -p $APP_HOME

RUN apk update \
    && apk upgrade \
    && apk add --upgrade gcc make libc-dev \
    && rm -rf /var/cache/apk/*

WORKDIR $APP_HOME

RUN gem install bundler:2.2.11

COPY Gemfile* $APP_HOME/

RUN BUNDLE_WITHOUT=${BUNDLE_WITHOUT} bundle install -j4

COPY . $APP_HOME
