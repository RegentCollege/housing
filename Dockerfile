FROM ruby:3-buster

ENV APP_DIR=/opt/regentcollege/current

RUN apt-get update && apt-get -y upgrade

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Cache bundle install
COPY Gemfile $APP_DIR/
COPY Gemfile.lock $APP_DIR/

ENV RAILS_ENV=production

RUN apt-get -y install git-core curl rsync zlib1g-dev build-essential default-mysql-client libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs
RUN cd $APP_DIR; gem install libv8 -v '3.16.14.7' -- --with-system-v8; bundle install

EXPOSE 9292
