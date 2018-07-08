FROM ruby:2.5.1-alpine3.7
ENV LANG C.UTF-8
# RUN apk update && \
#     apk upgrade && \
#     apk add --update\
#     bash \
#     build-base \
#     curl-dev \
#     git \
#     libxml2-dev \
#     libxslt-dev \
#     linux-headers \
#     mysql-dev \
#     openssh \
#     ruby-dev \
#     ruby-json \
#     tzdata \
#     yaml \
#     yaml-dev \
#     zlib-dev \
RUN apk add --update\
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    mysql-dev \
    tzdata

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
# RUN bundle update --jobs=4
RUN bundle install --jobs=4
ENV APP_HOME /helloworld
WORKDIR $APP_HOME
ADD . $APP_HOME

EXPOSE  3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
