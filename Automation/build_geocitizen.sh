#!/bin/sh

GEO_PATH=$1
# saving current dirrectory
CUR_DIR=`pwd`


if [[ "$GEO_PATH" == "" ]];
then
GEO_PATH=`pwd`
fi


if  [[ ! -d "$GEO_PATH" ]]; # check if PATH valid
then
    printf "\nRun with 'sudo' and Set Path (/f/papku/SoftServe\ IT\ Academy/Geocitizen) to Geocitizen:"
    printf "\n\n\tExample: sudo $0 yor_GEO_PATH\n"
    exit 1
fi


# building fron end
printf "\nBuilding Geocitizen FRONT END in $GEO_PATH""front-end/"
cd "$GEO_PATH""front-end/"
sudo npm run build
echo -e "Done\n"


# copy all from /front-end/dist to /src/main/webapp/
printf "Copy all from /front-end/dist to /src/main/webapp/"
sudo rsync -a "$GEO_PATH""front-end/dist/" "$GEO_PATH""src/main/webapp/"
echo -e "Done\n"


echo "Editing index.html in /src/main/webapp/"
# edit index.html in /src/main/webapp/ (/src/assets -> ./static/)
sed -i "s/[.]*\?\/src\/assets/.\/static/" "$GEO_PATH""src/main/webapp/index.html"
# edit index.html in /src/main/webapp/ (/static/css/ -> ./static/css/)
sed -i "s/[.]*\?\/static\/css/.\/static\/css/" "$GEO_PATH""src/main/webapp/index.html"
# edit index.html in /src/main/webapp/ (/static/js/ -> ./static/js/)
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "$GEO_PATH""src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "$GEO_PATH""src/main/webapp/index.html"
echo -e "Done\n"


# doing maven install
echo "Doing mvn install in $GEO_PATH"
cd "$GEO_PATH"
sudo mvn install
echo -e "Done\n"


# copy citizen.war from /target to /opt/latest/webapps/
# printf "Copy citizen.war from /target/ to /opt/tomcat/latest/webapps/"
# sudo cp "$GEO_PATH""target/citizen.war" "/opt/tomcat/latest/webapps/"
# echo -e "\nDone\n"


cd "$CUR_DIR"
exit 1