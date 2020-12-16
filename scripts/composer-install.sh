#!/bin/sh

# Based on https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
# Slightly modified

EXPECTED_CHECKSUM="$(curl -sS https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet -- --install-dir="$PATH_BIN" --filename=composer
RESULT=$?
rm composer-setup.php
exit $RESULT
