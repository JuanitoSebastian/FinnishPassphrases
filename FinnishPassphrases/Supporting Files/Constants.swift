//
//  Constants.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

let cRoundedCornerSize = CGSize(width: 5, height: 5)
let cPasswordSeparators: [SeparatorSymbol] = [.asterisk, .hyphen, .slash, .hash]
let cPassphraseNumberOfWordsRange: ClosedRange<Double> = 3...10
let cPassphraseNumberOfWordsRangeInt: ClosedRange = 3...10
let cProbabilityOfCapitalizedString: Double = 0.5
let cAboutWindowWidth: CGFloat = 400
let cAboutWindowHeight: CGFloat = 600
let cInitialNumberOfWOrds: Int = 4
let cInitialSeparatorSymbol: SeparatorSymbol = .hyphen
let cInitialMixedCase: Bool = false
let cTestingWords: [String] = ["ahdasrajaisesti", "ahdasrajaisuus", "ahdata", "ahde", "ahdekaunokki"]
let cMixedCaseRegex: String = "(?=.*[a-zäöå])(?=.*[A-ZÄÖÅ])"
