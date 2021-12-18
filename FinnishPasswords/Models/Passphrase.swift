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

    /// Returns the current passphrase as a string
    var passphrase: String {
        words.enumerated().reduce("", { concatenation, word in
            return word.offset < (words.count - 1) ?
                "\(concatenation)\(word.element)\(separator.symbol)" :
                "\(concatenation)\(word.element)" // No separator symbol added after last word
        })
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
