#!/usr/bin/env bash

cd /app

set +e
npx directus database install &>/dev/null
if [ "$?" == "0" ] ; then
    set -e
    echo "Database installed"
    ROLE=`npx directus roles create --name admin --admin`
    echo "Creating administrator role"
    npx directus users create --email admin@directus.com --password 123456 --role $ROLE
    echo "Creating administrator user"
    timeout 60
else
    set -e
    echo "Already initialized"
fi
