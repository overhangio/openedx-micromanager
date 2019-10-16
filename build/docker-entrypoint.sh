#! /bin/sh -e

if [ -e /app/env.sh ]
then
  echo "Loading env from /app/env.sh"
  . /app/env.sh
fi

exec "$@"