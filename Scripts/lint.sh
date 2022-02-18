#!/bin/sh

#  lint.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 18.2.2022.
#  

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
