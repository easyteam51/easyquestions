FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
&& apt-get update -qq \
&& apt-get install -y nodejs

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

RUN gem install bundler
RUN bundle install
RUN npm install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
