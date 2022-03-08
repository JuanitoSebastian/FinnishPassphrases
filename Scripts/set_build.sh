#!/bin/sh

#  set_version.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 23.2.2022.
#  

DIFF=`git diff`
if [[ $DIFF == "" ]]; then exit 0; fi

NUMBER_OF_COMMITS=`git rev-list HEAD --count`
BUILD_NUMBER=$((NUMBER_OF_COMMITS+1))

/usr/libexec/PlistBuddy -c "Set CFBundleVersion $BUILD_NUMBER" "${1}"
