FROM ruby:3.4.8-bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  unixodbc-dev \
  unixodbc \
  libssl-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -O https://sfc-repo.snowflakecomputing.com/odbc/linuxaarch64/3.13.0/snowflake-odbc-3.13.0.aarch64.deb && \
  dpkg -i snowflake-odbc-3.13.0.aarch64.deb && \
  rm snowflake-odbc-3.13.0.aarch64.deb

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

RUN echo $(uname -a)
