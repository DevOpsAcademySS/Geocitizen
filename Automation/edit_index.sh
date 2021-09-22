#!/bin/sh

echo "Editing index.html in /src/main/webapp/"
# edit index.html in /src/main/webapp/ (/src/assets -> ./static/)
sed -i "s/[.]*\?\/src\/assets/.\/static/" "./src/main/webapp/index.html"
# edit index.html in /src/main/webapp/ (/static/css/ -> ./static/css/)
sed -i "s/[.]*\?\/static\/css/.\/static\/css/" "./src/main/webapp/index.html"
# edit index.html in /src/main/webapp/ (/static/js/ -> ./static/js/)
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "./src/main/webapp/index.html"
sed -i "s/[.]*\?\/static\/js/.\/static\/js/g" "./src/main/webapp/index.html"
echo -e "Done\n"

exit 1