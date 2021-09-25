#!/bin/sh

DB_IP=$1
WEB_IP=$2

sed -i "s/localhost/$WEB_IP/" "./front-end/src/main.js"
sed -i "s/localhost/$WEB_IP/" "./front-end/config/index.js"    
sed -i "s/8081/8080/" "./front-end/config/index.js"
sed -i "s/localhost:8080/$WEB_IP:8080/" "./src/main/resources/application.properties"
sed -i "s/db.url=jdbc:postgresql:\/\/localhost/db.url=jdbc:postgresql:\/\/$DB_IP/" "./src/main/resources/application.properties"
sed -i "s/\^1.0.0-beta-7/1.0.0-beta-8/" "./front-end/package.json"
sed -i "s/\"vue-router\": \"^3.0.1\"/\"vue-router\": \"3.0.1\"/" "./front-end/package.json"