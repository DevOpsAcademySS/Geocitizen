#!/bin/sh

GEO_PATH=$1
# saving current dirrectory
CUR_DIR=`pwd`
DO_BUILD='no'
DO_INSTAll='no'
DO_COPY_FRONT='no'
DO_COPY_WAR='no'

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

echo -e "Do build front-end?[yes|no] default:no:"
read DO_BUILD

if [[ "$DO_BUILD" == "yes" ]];
then
    # building fron end
    printf "\nBuilding Geocitizen FRONT END in $GEO_PATH""front-end/"
    cd "$GEO_PATH""front-end/"
    sudo npm run build
    echo -e "Done\n"
fi

echo -e "Do copy front-end?[yes|no] default:no:"
read DO_COPY_FRONT

if [[ "$DO_COPY_FRONT" == "yes" ]];
then
    # copy all from /front-end/dist to /src/main/webapp/
    printf "Copy all from /front-end/dist to /src/main/webapp/"
    sudo rsync -a "$GEO_PATH""front-end/dist/" "$GEO_PATH""src/main/webapp/"
    echo -e "Done\n"
fi

echo -e "Edit index.html?[yes|no] default:no:"
read DO_COPY_FRONT
if [[ "$DO_COPY_FRONT" == "yes" ]];
then
    echo "Editing index.html in /src/main/webapp/"
    # edit index.html in /src/main/webapp/ (/src/assets -> ./static/)
    sed -i "s/[.]*\?\/src\/assets/.\/static/" "$GEO_PATH""src/main/webapp/index.html"
    # edit index.html in /src/main/webapp/ (/static/css/ -> ./static/css/)
    sed -i "s/[.]*\?\/static\/css/.\/static\/css/" "$GEO_PATH""src/main/webapp/index.html"
    # edit index.html in /src/main/webapp/ (/static/js/ -> ./static/js/)
    sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "$GEO_PATH""src/main/webapp/index.html"
    sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "$GEO_PATH""src/main/webapp/index.html"
    echo -e "Done\n"
fi

echo -e "Do mvn install?[yes|no] default:no:"
read DO_INSTAll

if [[ "$DO_INSTAll" == "yes" ]];
then
    # doing maven install
    echo "Doing mvn install in $GEO_PATH"
    cd "$GEO_PATH"
    mvn install
    echo -e "Done\n"
fi

echo -e "Do copy citizen.war?[yes|no] default:no:"
read DO_COPY_WAR

if [[ "$DO_COPY_WAR" == "yes" ]];
then
    # copy citizen.war from /target to /opt/latest/webapps/
    printf "Copy citizen.war from /target/ to /opt/tomcat/latest/webapps/"
    sudo cp "$GEO_PATH""target/citizen.war" "/opt/tomcat/latest/webapps/"
    echo -e "\nDone\n"
fi

cd "$CUR_DIR"
exit 1