#!/bin/sh

#  generate_mockingbird_mocks.sh
#  FinnishPassphrases
#
#  Created by Juan Covarrubias on 18.2.2022.
#  

set -eu

${SRCROOT}/MockingbirdSupport/mockingbird generate \
  --targets 'FinnishPassphrases' \
  --outputs "${SRCROOT}/MockingbirdMocks/FinnishPasswordsTests-FinnishPasswordsMocks.generated.swift" \
  --support "${SRCROOT}/MockingbirdSupport"
