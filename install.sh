#!/bin/bash
interface=$(ip a | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2a;getline}')
#echo "interface =$interface"
tomcatip="http://$(ip a s $interface | awk -F"[/ ]+" '/inet / {print $3}')"
sed -i -E '/(front.*|back.*)[Uu]rl/s/p:.*:/p:\/\/'$tomcatip':/g' ./src/main/resources/application.properties ./front-end/src/main.js
read -r -p "enter database IP: " DBip
sed -i -E '/db.url/s/l:.*\/ss/l:\/\/'$DBip':5432\/ss/g' ./src/main/resources/application.properties
cd ./front-end
sed -i -E '/vue-(mat|rou)/s/\^//g' package.json
npm install
npm audit fix
npm run build
cp -r ./dist/* ../src/main/webapp/
cd ..
sed -i -E '/\/static/s/=\/static/=.\/static/g' src/main/webapp/index.html
mvn install
webappspath=$(sudo find / -type d -name "webapps")
sudo mv target/citizen.war $webappspath
sudo systemctl restart tomcat*

echo "Geocitizen is ready: $tomcatip:8080/citizen"
echo "Enjoy!"
