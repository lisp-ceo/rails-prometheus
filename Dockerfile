FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick memcached --force-yes
RUN mkdir /app

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler # run latest bundler
RUN gem install rainbow -v '2.2.1' # Bug in rails12factor requires installing this first
RUN bundle install
ADD . /app

# App
RUN ln -sf /dev/stdout /app/log/production.log

EXPOSE 80
CMD ./bin/start
