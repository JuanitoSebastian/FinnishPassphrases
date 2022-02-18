#!/bin/sh

#  run_xcode_tests.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 18.2.2022.
#  

xcodebuild test -configuration "Debug" ARCHS="x86_64" -destination 'platform=macOS' -project "FinnishPassphrases.xcodeproj" -scheme "FinnishPassphrases" -enableCodeCoverage YES test | xcbeautify
