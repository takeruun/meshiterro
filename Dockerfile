FROM ruby:2.7.1-alpine3.12

RUN apk add --update-cache --no-cache tzdata libxml2-dev \
  make gcc libc-dev g++ linux-headers imagemagick \
  mysql-dev mysql-client nodejs git yarn && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /meshiterro

WORKDIR /meshiterro

ADD Gemfile /meshiterro/Gemfile
ADD Gemfile.lock /meshiterro/Gemfile.lock

RUN gem install bundle && \
  bundle install

RUN rm -rf /usr/local/bundle/cache/* /workdir/vendor/bundle/cache/*

RUN rails -v

ADD . /meshiterro

RUN bundle exec rails assets:precompile