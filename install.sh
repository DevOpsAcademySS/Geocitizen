#!/bin/bash
tomcatip=$(cat $HOME/.cache/amazon_ip)
DBip=$(cat $HOME/.cache/ubuntu_ip)
sed -i -E '/(front.*|back.*)[Uu]rl/s/p:.*:/p:\/\/'$tomcatip':/g' ./src/main/resources/application.properties ./front-end/src/main.js
#read -r -p "enter database IP: " DBip
sed -i -E '/db.url/s/l:.*\/ss/l:\/\/'$DBip':5432\/ss/g' ./src/main/resources/application.properties
cd ./front-end
sed -i -E '/vue-(mat|rou)/s/\^//g' package.json
npm install
npm audit fix
npm run build
cp -r ./dist/* ../src/main/webapp/
cd ..
sed -i -E '/\/static/s/=\/static/=.\/static/g' src/main/webapp/index.html
sed -i -E '/repo.spring.io\/milestone/s/http/https/g' pom.xml
mvn install
