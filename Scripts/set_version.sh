#!/bin/sh

#  set_version.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 23.2.2022.
#  

# do not assign the new build number if there is no changes
DIFF=`git diff`
if [[ $DIFF == "" ]]; then exit 0; fi

# path to the property list where the version number should be changed
PLIST="${PROJECT_DIR}/${INFOPLIST_FILE}"

# the latest tag that will be used as a short version number
VERSION_NUMBER=`git describe | awk '{ split($0, a, "-"); print a[1] }'`

# the number of commits in repository to be used for the build number
NUMBER_OF_COMMITS=`git rev-list HEAD --count`

# a future build number should consider its own commit
BUILD_NUMBER=$((NUMBER_OF_COMMITS+1))

/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString $VERSION_NUMBER" "${PLIST}"
/usr/libexec/PlistBuddy -c "Set CFBundleVersion $BUILD_NUMBER" "${PLIST}"
