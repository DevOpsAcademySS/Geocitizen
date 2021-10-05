#/bin/bash

sed -i 's/<link href=/&./' ./src/main/webapp/index.html
sed -i 's/<script type=text\/javascript src=/&./g' ./src/main/webapp/index.html