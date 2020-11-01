FROM node:latest

RUN apt-get update && apt-get install mysql-client -y

RUN mkdir /app \
  && cd /app \
  && npm init -y \
  && npm install directus \
  && npm install mysql

RUN mkdir -p /app/init

COPY .env /app/.env
COPY entrypoint.sh /entrypoint.sh

VOLUME /app/init/

WORKDIR /app

ENTRYPOINT /entrypoint.sh
