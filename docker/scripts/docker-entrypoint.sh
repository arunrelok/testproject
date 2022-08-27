#!/bin/sh

# unset variables are errors and non-zero return values exit the whole script
set -eu

# envsubst to write configuration from templates
envsubst < /usr/share/nginx/html/realoq-ui/config.js.template > config.js
# delete templates
rm -f /usr/share/nginx/html/realoq-ui/config.js.template

# replaces placeholder with value in index.html file
#sed -i "s|%PUBLIC_URL%|$publicUrl|g" /usr/share/nginx/html/isa-tadmin-webapp/index.html

sed -i "s|location /|server_tokens off;\n\n    absolute_redirect off;\n\n    location /realoq-ui|g" /etc/nginx/conf.d/default.conf

## redirects to application's index.html
sed -i "s|index  index.html index.htm;|#index  index.html index.htm;\n        try_files \$uri \$uri/ /realoq-ui/index.html;|g" /etc/nginx/conf.d/default.conf
