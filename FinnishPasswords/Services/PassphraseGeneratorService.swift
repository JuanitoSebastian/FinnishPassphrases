//
//  PasswordGeneratorService.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 19.5.2021.
//

import Foundation

class PassphraseGeneratorService: ObservableObject {

    let kotusWordService: KotusWordService

    init(kotusWordService: KotusWordService) {
        self.kotusWordService = kotusWordService
    }
}

// MARK: - Functions
extension PassphraseGeneratorService {

    /// Generates a new passphrase. Old passphrase is replaced with new one.
    func generatePassphrase(
        numOfWords: Int,
        separatorSymbol: SeparatorSymbol,
        wordCapitalization: Bool
    ) -> Passphrase {
        let words = generateWords(numberOfWords: numOfWords)

        let passphraseToReturn = Passphrase(
            words: wordCapitalization ? randomizeWordCase(words) : words,
            separator: separatorSymbol
        )

        return passphraseToReturn
    }

    func updatePassphraseSeparatorSymbol(
        passphrase: Passphrase,
        separatorSymbol: SeparatorSymbol
    ) -> Passphrase {
        guard passphrase.separator != separatorSymbol else { return passphrase }
        return Passphrase(words: passphrase.words, separator: separatorSymbol)
    }

    func updatePassphraseWordCapitalization(
        passphrase: Passphrase,
        wordCapitalization: Bool
    ) -> Passphrase {
        let words = wordCapitalization ?
            randomizeWordCase(passphrase.words) : removeRandomizedWordCase(passphrase.words)

        return Passphrase(words: words, separator: passphrase.separator)
    }

}

// MARK: - Private functions
extension PassphraseGeneratorService {

    /// Generates a [String] with random words that are fetched from KotusWordService
    /// - Parameter numberOfWords: The number of words that will be generated
    private func generateWords(numberOfWords: Int) -> [String] {
        var words: [String] = []
        for _ in 0..<numberOfWords {
            words.append(kotusWordService.randomWord())
        }
        return words
    }

    /// Capitalizes random words in the array. The function make sure that the array includes both capitalized
    /// and non capitalized words.
    /// - Parameter words: A [String] that will be worked on
    private func randomizeWordCase(_ words: [String]) -> [String] {
        var wordsRanomizedCase = words

        var capitalized: Bool = false
        var nonCapitalized: Bool = false
        for index in 0..<words.count {
            if Bool.random() {
                wordsRanomizedCase[index] = wordsRanomizedCase[index].flipCase()
                capitalized = true
                continue
            }
            nonCapitalized = true
        }

        if !capitalized || !nonCapitalized {
            let randomIndex = Int.random(in: 0..<wordsRanomizedCase.count)
            wordsRanomizedCase[randomIndex] = wordsRanomizedCase[randomIndex].flipCase()
        }

        return wordsRanomizedCase
    }

    private func removeRandomizedWordCase(_ words: [String]) -> [String] {
        var wordsNonRadomized: [String] = words
        for index in 0..<wordsNonRadomized.count where wordsNonRadomized[index].first?.isUppercase == true {
            wordsNonRadomized[index] = wordsNonRadomized[index].flipCase()
        }
        return wordsNonRadomized
    }
}
