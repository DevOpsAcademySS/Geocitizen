#/bin/bash

sed -i "s!<link href=/!<link href=./!g" ./src/main/webapp/index.html
sed -i "s!<script type=text/javascript src=/!<script type=text/javascript src=./!g" ./src/main/webapp/index.html