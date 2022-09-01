![Header Image](https://raw.githubusercontent.com/JuanitoSebastian/FinnishPassphrases/development/docs/imgs/GitHubHeader.png)

[![Build & Tests](https://github.com/JuanitoSebastian/FinnishPassphrases/actions/workflows/build_test.yml/badge.svg)](https://github.com/JuanitoSebastian/FinnishPassphrases/actions/workflows/build_test.yml)
[![codecov](https://codecov.io/gh/JuanitoSebastian/FinnishPassphrases/branch/main/graph/badge.svg?token=AIWQRJR7VB)](https://codecov.io/gh/JuanitoSebastian/FinnishPassphrases)

A simple menu bar application for generating secure passphrases in Finnish. Passphrases are generated using a list of 90,000 words provided by the [Institute for the Languages of Finland](https://kaino.kotus.fi/sanat/nykysuomi/).

![Screenshot of the app](https://raw.githubusercontent.com/JuanitoSebastian/FinnishPassphrases/development/docs/imgs/popover1.png)

## Structure
- 🗂 **FinnishPassphrases.xcodeproj**: Xcode project
- 🗂 **FinnishPassphrases**: Application source
- 🗂 **Tests**: Unit and EndToEnd tests
- 🗂 **MockingbirdSupport**: Supporting files for mocking framework
- 🗂 **Scripts**: Scripts used for building the project
- 🗂 **docs**: Documentation and [product page](https://juanitosebastian.github.io/FinnishPassphrases/)

## Running the application in development environment
1. Download the latest [release](https://github.com/JuanitoSebastian/FinnishPassphrases/releases) or clone the repository:
```
git clone https://github.com/JuanitoSebastian/FinnishPassphrases.git
```
2. Open FinnishPassphrases.xcodeproj in Xcode
3. Build and run the project with `⌘ + R`

If you do not have SwiftLint installed remove Swiftlint from the build phases.

## Testing
Open FinnishPassphrases.xcodeproj to access the Xcode workspace and run the tests by pressing `⌘ + U`.

## Dependencies
- [Mockingbird](https://mockingbirdswift.com) used for mocking classes in unit tests
- [WrappingHStack](https://github.com/dkk/WrappingHStack) used for displaying for displaying the passphrase
- [Popover](https://github.com/iSapozhnik/Popover) menu bar popover
