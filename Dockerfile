FROM ruby:3.2.2-slim-bookworm

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    git \
    libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

COPY app/Gemfile* /tmp/
WORKDIR /tmp
RUN bundle config set --local system 'true' && \
  bundle install --retry=5 --jobs=5

EXPOSE 3000

WORKDIR /app

ADD . /app

CMD ["./bin/rails", "server"]
