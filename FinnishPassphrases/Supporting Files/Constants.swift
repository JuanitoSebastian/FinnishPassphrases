//
//  Constants.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

// MARK: - Fonts
let cPasswordFontMain = Font.system(.body, design: .monospaced).weight(.medium)
let cPasswordFontMedium = Font.system(.headline, design: .monospaced)
let cSeparatorFlickerFontSeparator = Font.system(.title, design: .monospaced).weight(.medium)
let cSeparatorFlickerFontDescription = Font.system(.title2, design: .default)
let cUiFontMedium = Font.system(size: 16, design: .default)
let cUiFontSmall = Font.system(size: 12, design: .default).weight(.semibold)
let cUiTitleFont = Font.system(size: 40, design: .rounded).weight(.semibold)
let cUiAppDescriptionFont = Font.system(size: 18, design: .default)
let cFooterFont = Font.system(.footnote, design: .default)

// MARK: - Colors


// MARK: - Padding
let cGeneratorViewRowPadding = EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
let cGeneratorViewColumnPadding = EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 1)
let cMainContentPadding = EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15)
let cModifierButtonPadding = EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)

// MARK: - Constants
let cRoundedCornerSize = CGSize(width: 5, height: 5)
let cPasswordSeparators: [SeparatorSymbol] = [.asterisk, .hyphen, .slash, .hash]
let cPassphraseNumberOfWordsRange: ClosedRange<Double> = 3...10
let cPassphraseNumberOfWordsRangeInt: ClosedRange = 3...10
let cProbabilityOfCapitalizedString: Double = 0.5
let cAboutWindowWidth: CGFloat = 600
let cAboutWindowHeight: CGFloat = 338

// MARK: - Animations
let cPassphraseAreaClickAnimation = Animation.interpolatingSpring(
    mass: 1,
    stiffness: 100,
    damping: 4,
    initialVelocity: 0.5
)
let cHoverAnimation = Animation.easeInOut(duration: 0.2)
let cFlickerButtonAnimation = Animation.easeOut(duration: 0.2)
let cIconClickAnimation = Animation.spring()
