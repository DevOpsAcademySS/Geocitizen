#!/bin/sh

cp -r "./front-end/dist/." "./src/main/webapp/"
sed -i "s/[.]*\?\/src\/assets/.\/static/" "./src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/css/.\/static\/css/" "./src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "./src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "./src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "./src/main/webapp/index.html"

exit 1