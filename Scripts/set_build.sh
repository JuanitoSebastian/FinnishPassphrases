#!/bin/sh

#  set_version.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 23.2.2022.
#

git=$(sh /etc/profile; which git)
number_of_commits=$("$git" rev-list HEAD --count)

target_plist="$TARGET_BUILD_DIR/$INFOPLIST_PATH"
dsym_plist="$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Info.plist"

for plist in "$target_plist" "$dsym_plist"; do
  if [ -f "$plist" ]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $number_of_commits" "$plist"
  fi
done
