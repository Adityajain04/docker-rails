FROM ruby:2.6.3

RUN apt-get update

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /docker-rails
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

RUN gem install rails bundler
COPY docker-rails/Gemfile Gemfile
WORKDIR $APP_HOME
RUN bundle install

ADD Gemfile* $APP_HOME/
ADD . $APP_HOME