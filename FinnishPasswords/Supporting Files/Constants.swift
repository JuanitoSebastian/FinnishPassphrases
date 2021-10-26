//
//  Constants.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

// Fonts
let fPasswordFontMain = Font.system(.body, design: .monospaced)
let fPasswordFontMedium = Font.system(.headline, design: .monospaced)

// Colors
let contentBackgroundColor = Color("ContentBg")
let passphraseBackgroundColor = Color("PassphraseDisplayBg")
let passphraseSeparatorColor = Color("PassphraseSeparatorColor")

// Constants
let fRoundedCornerSize = CGSize(width: 5, height: 5)
let fPasswordSeparators: [SeparatorSymbol] = [.asterisk, .hyphen, .slash, .hash]
let fMinimumNumberOfWordsInPassphrase = 3
let fMaximumNumberOfWordsInPassphrase = 10
let fProbabilityOfCapitalizedString: Double = 0.5
