FROM ruby:2.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle config --global frozen 1
RUN bundle install --without development test
ENV SECRET_KEY_BASE f3994e2804113227a147eff20e7fa5a333722216fe97ce3c21adadb11712d8db3ad073865e68cd246df53571809f889ff7eb9230ff3d9d332a7ff20a4f165401

COPY . /usr/src/app


#EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]


