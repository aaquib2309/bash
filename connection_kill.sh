#!/bin/bash

# MySQL Credentials
MYSQL_USER="root"
MYSQL_PASSWORD="KVSDATA@#321"
MYSQL_DATABASE="kvsdata"
MYSQL_HOST="127.0.0.1"

# Define the SQL query to identify connections with time > 100 seconds
QUERY="SELECT ID FROM INFORMATION_SCHEMA.PROCESSLIST WHERE TIME > 100 AND USER != 'system user';"

# Execute the query to get the IDs of connections to kill
IDS=$(mysql -h"MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D "$MYSQL_DATABASE" -N -s -e "$QUERY")

# Loop through the IDs and kill the corresponding connections
for ID in $IDS; do
    echo "Killing connection with ID: $ID"
    mysql -h"MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D "$MYSQL_DATABASE" -e "KILL $ID;"
done
