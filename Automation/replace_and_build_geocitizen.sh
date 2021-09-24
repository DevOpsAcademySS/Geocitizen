#!/bin/sh

DB_IP=$1
WEB_IP=$2
GEO_PATH=$3
REGEXP="^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$"

if  [[ ! "$DB_IP" =~ $REGEXP || ! "$WEB_IP" =~ $REGEXP || ! -d "$GEO_PATH" ]]; # check if IP and PATH valid
then
    printf "Set the Servers IPs(0.0.0.0) with Path (/f/papku/SoftServe\ IT\ Academy/Geocitizen) to Geocitizen:"
    printf "\n\n\tExample: $0 yor_DB_IP yor_WEB_IP yor_GEO_PATH\n"
    exit 1
fi

printf "Strting:\n"
./replace_ip_and_port_geocitizen.sh "$DB_IP" "$WEB_IP" "$GEO_PATH"
./build_geocitizen.sh "$GEO_PATH"
printf "\n\nSuccess\n"