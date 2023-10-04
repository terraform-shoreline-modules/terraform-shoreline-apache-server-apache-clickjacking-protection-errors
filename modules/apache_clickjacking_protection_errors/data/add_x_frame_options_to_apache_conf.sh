bash

#!/bin/bash

APACHE_CONF="/etc/apache2/apache2.conf"

X_FRAME_OPTS="Header always append X-Frame-Options SAMEORIGIN"



# Check if Apache config file exists

if [ ! -f $APACHE_CONF ]; then

    echo "Error: Apache config file not found at $APACHE_CONF"

    exit 1

fi



# Check if X-Frame-Options are already set

if grep -q "X-Frame-Options" $APACHE_CONF; then

    echo "X-Frame-Options are already set in $APACHE_CONF"

    exit 0

fi



# Add X-Frame-Options to Apache config file

echo $X_FRAME_OPTS >> $APACHE_CONF



# Restart Apache server to apply changes

systemctl restart apache2