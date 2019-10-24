FROM  node:12.12.0-alpine

RUN apk add --no-cache autoconf automake build-base libpng-dev pngquant

WORKDIR /app
COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 1995
