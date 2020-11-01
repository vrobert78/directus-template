#!/bin/bash

while ! mysqladmin ping -h db --silent; do
    sleep 1
done

FILE=/app/init/initialized

if test -f "$FILE"; then
    echo "Already initialized"
else
    cd /app
    npx directus database install
    ROLE=`npx directus roles create --name admin --admin`
    npx directus users create --email admin@directus.com --password 123456 --role $ROLE
    touch $FILE
fi

exec npx directus start