FROM ruby:2.7-alpine3.10
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /src

COPY Gemfile Gemfile.lock ./ 
RUN bundle install
COPY . .
# CMD ["ruby", "./src/value_consumer.rb"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT ["ruby", "./src/value_consumer.rb"]