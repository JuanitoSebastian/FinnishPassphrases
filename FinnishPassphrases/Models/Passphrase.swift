//
//  Passphrase.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

/// A Passphrase. The words of a Passphrase are stored in an array of strings and the separator
/// between the words is determined by a SeparatorSymbol variable. Passphrase objects can
/// be generated using the PassphraseGeneratorService.
struct Passphrase {

    /// Contains the words of a Passphrase
    var words: [String]

    /// The SeparatorSymbol used in the Passphrase
    var separator: SeparatorSymbol

}

// MARK: - Computed properties
extension Passphrase {

    /// The current passphrase as a string.
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

    /// Does the Passphrase contain mixed case words?
    var wordCapitalization: Bool {
        var upperCaseFound = false
        var lowerCaseFound = false
        for word in words {
            if word.first?.isUppercase != nil && word.first!.isUppercase { upperCaseFound = true }
            if word.first?.isLowercase != nil && word.first!.isLowercase { lowerCaseFound = true }
            if upperCaseFound && lowerCaseFound { return true }
        }
        return false
    }

}

// MARK: - Equatable
extension Passphrase: Equatable {

    /// Compares two Passphrase objeccts and determines if they are equal. Two Passphrases are
    /// equal if their `words` arrays are equal and if their `separator` SeparatorSymbols are
    /// equal.
    static func == (lhs: Passphrase, rhs: Passphrase) -> Bool {
        return lhs.separator == rhs.separator &&
            lhs.words == rhs.words
    }

}

// MARK: - Custom String Convertible
extension Passphrase: CustomStringConvertible {

    /// A description of the Passphrase object. Used for logging.
    var description: String {
        """
        Passphrase: \(passphrase)
        numOfWords: \(numOfWords)
        separator: \(separator)
        """
    }

}
