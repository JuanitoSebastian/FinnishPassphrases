#!/bin/sh

#  download_mockingbird.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 18.2.2022.
#

cd MockingbirdSupport

FILE=mockingbird
if [ -f "$FILE" ]; then
    echo "$FILE was found"
else
    echo "Downloading Mockingbird"
    curl -Lo Mockingbird.zip "https://github.com/birdrides/mockingbird/releases/download/0.18.1/Mockingbird.zip"
    unzip -o Mockingbird.zip mockingbird
    rm -rf Mockingbird.zip
    echo "Mockingbird was downloaded 🦅"
fi

