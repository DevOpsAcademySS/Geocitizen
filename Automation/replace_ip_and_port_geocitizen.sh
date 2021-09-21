#!/bin/sh

DB_IP=$1
WEB_IP=$2
GEO_PATH=$3
IP_REGEXP="[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}"
REGEXP="^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$"

if  [[ ! "$DB_IP" =~ $REGEXP || ! "$WEB_IP" =~ $REGEXP || ! -d "$GEO_PATH" ]]; # check if IP and PATH valid
then
    printf "Set the Servers IPs(0.0.0.0) with Path (/f/papku/SoftServe\ IT\ Academy/Geocitizen) to Geocitizen:"
    printf "\n\n\tExample: $0 yor_DB_IP yor_WEB_IP yor_GEO_PATH\n"
    exit 1
fi

printf "Servers IPs:\n\tDB_IP = '$1'\n\tWEB_IP = '$2'\n\tGEO_PATH='$3'\n\n";
#=====================================================================

# replace IP in /front-end/src/main.js
sed -i "s/$IP_REGEXP/$WEB_IP/" "$GEO_PATH""front-end/src/main.js"
echo "Changed IP in /front-end/src/main.js to $WEB_IP"

# replace IP in /front-end/config/index.js
sed -i "s/$IP_REGEXP/$WEB_IP/" "$GEO_PATH""front-end/config/index.js"    
echo "Changed IP in /front-end/config/index.js to $WEB_IP"

# replace PORT number in /front-end/config/index.js
sed -i "s/8081/8080/" "$GEO_PATH""front-end/config/index.js"
echo "Changed PORT in /front-end/config/index.js to 8080"

# replace IP in /src/main/resources/application.properties
sed -i "s/$IP_REGEXP:8080/$WEB_IP:8080/" "$GEO_PATH""src/main/resources/application.properties"
echo "Changed IP in /src/main/resources/application.properties to $WEB_IP for FRONTEND"

# replace IP in /src/main/resources/application.properties
sed -i "s/db.url=jdbc:postgresql:\/\/$IP_REGEXP/db.url=jdbc:postgresql:\/\/$DB_IP/" "$GEO_PATH""src/main/resources/application.properties"
echo "Changed IP in /src/main/resources/application.properties to $DB_IP for DATABASE"

# replace dependencies in /front-end/package.json
sed -i "s/\^4.7.2/4.7.2/" "$GEO_PATH""front-end/package.json"
sed -i "s/\^1.0.0-beta-7/1.0.0-beta-8/" "$GEO_PATH""front-end/package.json"
sed -i "s/\"vue-router\": \"^3.0.1\"/\"vue-router\": \"3.0.1\"/" "$GEO_PATH""front-end/package.json"

printf "Changed package.json in /front-end/package.json:"
printf '\n\t"node-sass": "^4.7.2" -> "4.7.2"'
printf '\n\t"vue-material": "^1.0.0-beta-7" -> "1.0.0-beta-8"'
printf '\n\t"vue-router": "^3.0.1" -> "3.0.1"'

exit 1