#!/usr/bin/env bash

set +e
npx directus database install &>/dev/null
if [ "$?" == "0" ] ; then
    set -e
    cd /app
    npx directus database install
    ROLE=`npx directus roles create --name admin --admin`
    npx directus users create --email admin@directus.com --password 123456 --role $ROLE
else
    set -e
    echo "Already initialized"
fi
echo "Checking database connection"
timeout ${DB_TIMEOUT:-"30"} bash -c 'until nc -z -w 1 "$0" $1; do sleep 1; done' "${DB_HOST}" ${DB_PORT}