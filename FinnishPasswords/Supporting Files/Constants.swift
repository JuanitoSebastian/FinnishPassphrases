//
//  Constants.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

// MARK: - Fonts
let fPasswordFontMain = Font.system(.body, design: .monospaced)
let fPasswordFontMedium = Font.system(.headline, design: .monospaced)
let fUiFontMedium = Font.system(size: 16, design: .default)
let fUiFontSmall = Font.system(size: 12, design: .default)

// MARK: - Colors
let backdropColor = Color("backdrop")

let passphraseBackgroundColor = Color("passphrase-area-border")
let passphraseBackgroundColorHover = Color("passphrase-area-border-hover")
let passphraseBackgroundColorClick = Color("passphrase-area-border-onclick")

let passphraseSeparatorColor = Color("passphrase-separator")

// MARK: - Padding
let fPassphraseAreaPadding = EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
let fGeneratorViewRowPadding = EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
let fGeneratorViewColumnPadding = EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 1)

// MARK: - Constants
let fRoundedCornerSize = CGSize(width: 5, height: 5)
let fPasswordSeparators: [SeparatorSymbol] = [.asterisk, .hyphen, .slash, .hash]
let fMinimumNumberOfWordsInPassphrase = 3
let fMaximumNumberOfWordsInPassphrase = 10
let fProbabilityOfCapitalizedString: Double = 0.5

// MARK: - Animations
let fPassphraseAreaClickAnimation = Animation.interpolatingSpring(
    mass: 1,
    stiffness: 100,
    damping: 4,
    initialVelocity: 0.5
)
let fPassphraseAreaHoverAnimation = Animation.easeInOut(duration: 0.2)
