#/bin/bash

sed -i "s!front.url=http://*.*.*.*:8080/citizen/#!front.url=http://$2:8080/citizen/#!g" ./src/main/resources/application.properties
sed -i "s!front-end.url=http://*.*.*.*:8080!front-end.url=http://$2:8080!g" ./src/main/resources/application.properties
sed -i "s!db.url=jdbc:postgresql://*.*.*.*:5432!fdb.url=jdbc:postgresql://$1:5432!g" ./src/main/resources/application.properties
sed -i "s!backEndUrl = 'http://*.*.*.*:8080!backEndUrl = 'http://$2:8080!g" ./front-end/src/main.js