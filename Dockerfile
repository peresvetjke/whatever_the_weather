FROM ruby:2.7.6

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN bundle install
RUN bundle exec rake db:seed

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000

