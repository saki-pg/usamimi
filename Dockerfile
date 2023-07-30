FROM ruby:3.1.4

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリの設定
WORKDIR /usamimi

# ホストのGemfileとGemfile.lockをコピー
COPY Gemfile /usamimi/Gemfile
COPY Gemfile.lock /usamimi/Gemfile.lock

# bundlerのインストールとbundle installの実行
RUN gem install bundler
RUN bundle install --without development test

# ホストの全てのファイルをコピー
COPY . /usamimi

# Railsが起動するためのスクリプトをコピーと実行権限の付与
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
