FROM  node:12.12.0-alpine

# bash pngquant optipng lcms2-dev
RUN apk add --no-cache autoconf automake build-base libpng-dev

WORKDIR /app
COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 1995