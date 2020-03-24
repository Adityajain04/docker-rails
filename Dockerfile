FROM ruby:2.6.3

RUN apt-get update

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /docker-rails
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ADD . $APP_HOME