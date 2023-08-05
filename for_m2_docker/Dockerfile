FROM ruby:3.1.4

WORKDIR /usamimi

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

COPY Gemfile /usamimi/Gemfile
COPY Gemfile.lock /usamimi/Gemfile.lock

RUN gem install bundler
RUN bundle install --without development test

COPY . /usamimi

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
