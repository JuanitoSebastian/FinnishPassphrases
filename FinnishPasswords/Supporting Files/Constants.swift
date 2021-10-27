//
//  Constants.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

// MARK: - Fonts
let cPasswordFontMain = Font.system(.body, design: .monospaced)
let cPasswordFontMedium = Font.system(.headline, design: .monospaced)
let cUiFontMedium = Font.system(size: 16, design: .default)
let cUiFontSmall = Font.system(size: 12, design: .default).weight(.semibold)

// MARK: - Colors
let cBackdropColor = Color("backdrop")

let cPpassphraseBorderColor = Color("passphrase-area-border")
let cPassphraseBorderColorHover = Color("passphrase-area-border-hover")
let cPassphraseBorderColorClick = Color("passphrase-area-border-onclick")
let cPassphraseBackgroundColor = Color("passphrase-area-background")
let cPassphraseBackgroundColorHover = Color("passphrase-area-background-hover")

let cPassphraseSeparatorColor = Color("passphrase-separator")

let cCheckboxTopColor = Color("checkbox-top")
let cCheckboxBottomColor = Color("checkbox-bottom")
let cCheckboxBorderColor = Color("checkbox-border")

// MARK: - Padding
let cPassphraseAreaPadding = EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
let cGeneratorViewRowPadding = EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
let cGeneratorViewColumnPadding = EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 1)

// MARK: - Constants
let cRoundedCornerSize = CGSize(width: 5, height: 5)
let cPasswordSeparators: [SeparatorSymbol] = [.asterisk, .hyphen, .slash, .hash]
let cMinimumNumberOfWordsInPassphrase = 3
let cMaximumNumberOfWordsInPassphrase = 10
let cProbabilityOfCapitalizedString: Double = 0.5

// MARK: - Animations
let cPassphraseAreaClickAnimation = Animation.interpolatingSpring(
    mass: 1,
    stiffness: 100,
    damping: 4,
    initialVelocity: 0.5
)
let cPassphraseAreaHoverAnimation = Animation.easeInOut(duration: 0.2)
