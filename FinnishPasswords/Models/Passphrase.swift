//
//  Passphrase.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

class Passphrase: ObservableObject {

    @Published var words: [String]
    @Published var separator: SeparatorSymbol

    init(words: [String], separator: SeparatorSymbol) {
        self.words = words
        self.separator = separator
    }
}

// MARK: - Computed properties
extension Passphrase {

    /// Generates passphrase string
    var passphrase: String {
        var passphraseString = ""
        for (index, word) in words.enumerated() {
            passphraseString.append(word)

            if index < (words.count - 1) {
                passphraseString.append(separator.symbol)
            }
        }
        return passphraseString
    }

    /// Number of words in passphrase
    var numOfWords: Int {
        words.count
    }

    /// Number of characters in passhrase
    var numOfCharacters: Int {
        passphrase.count
    }
}
