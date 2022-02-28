//
//  PasswordGeneratorService.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 19.5.2021.
//

import Foundation

/// A class that generates new Passphrase objects 🏭
class PassphraseGeneratorService {

  let kotusWordService: KotusWordService

  /// - Parameter kotusWordService: KotusWordService object to use for fetching random Finnish words
  init(kotusWordService: KotusWordService) {
    self.kotusWordService = kotusWordService
  }
}

// MARK: - Functions
extension PassphraseGeneratorService {

  /// Generates a new Passphrase object with given arguments
  /// - Parameter numOfWords: Number of words in Passphrase
  /// - Parameter separatorSymbol: SeparatorSymbol in Passphrase
  /// - Parameter wordCapitaliation: Feature varying capitalization in Passphrase
  /// - Returns: A new Passphrase object
  func generatePassphrase(
    numOfWords: Int,
    separatorSymbol: SeparatorSymbol,
    wordCapitalization: Bool
  ) -> Passphrase {
    let words = generateWords(numberOfWords: numOfWords, mixedCase: wordCapitalization)

    let passphraseToReturn = Passphrase(
      words: words,
      separator: separatorSymbol
    )

    return passphraseToReturn
  }

  /// Updated Passsphrase to use given SeparatorSymbol
  /// - Parameter passphrase: Passphrase object to update
  /// - Parameter separatorSymbol : SeparatorSymbol to use
  /// - Returns: A new Passphrase object
  func updatePassphraseSeparatorSymbol(
    passphrase: Passphrase,
    separatorSymbol: SeparatorSymbol
  ) -> Passphrase {
    guard passphrase.separator != separatorSymbol else { return passphrase }
    return Passphrase(
      words: passphrase.words,
      separator: separatorSymbol
    )
  }

  /// Update Passphrase word capitalization
  /// - Parameter passphrase : Passphrase to update
  /// - Parameter wordCapitalization: To use varying capitalization or no
  /// - Returns: A new Passphrase obejct
  func updatePassphraseWordCapitalization(
    passphrase: Passphrase,
    wordCapitalization: Bool
  ) -> Passphrase {
    let words = wordCapitalization
    ? randomizeWordCase(passphrase.words)
    : removeRandomizedWordCase(passphrase.words)

    return Passphrase(words: words, separator: passphrase.separator)
  }

  /// Updates the number of words in a given Passphrase
  /// - Parameter passphrase: Passphrase to update
  /// - Parameter numOfWords: The number of words
  /// - Returns: A new Passphrase obejct
  func updatePassphraseNumOfWords(
    passphrase: Passphrase,
    numOfWords: Int
  ) -> Passphrase {
    guard passphrase.numOfWords != numOfWords else { return passphrase }

    let shouldContainMixedCase = passphrase.mixedCase

    var words = passphrase.words
    let difference = numOfWords - passphrase.numOfWords

    if difference > 0 {
      words.append(contentsOf: generateWords(numberOfWords: difference, mixedCase: shouldContainMixedCase))
    }

    if difference < 0 {
      let range = (words.count - abs(difference))...words.count - 1
      words.removeSubrange(range)

      if shouldContainMixedCase && !wordArrayContainsMixedCase(words) {
        words = randomizeWordCase(words)
      }
    }

    return Passphrase(words: words, separator: passphrase.separator)
  }

}

// MARK: - Private functions
extension PassphraseGeneratorService {

  /// Generates a [String] with random words that are fetched from KotusWordService
  /// - Parameter numberOfWords: The number of words that will be generated
  private func generateWords(numberOfWords: Int, mixedCase: Bool = false) -> [String] {
    var words: [String] = []
    for _ in 0..<numberOfWords {
      words.append(generateWord(mixedCase))
    }
    return words
  }

  /// Returns a random word from KotusWordService.
  /// - Parameter mixedCase: If set to true, the returned word might be capitalized
  private func generateWord(_ mixedCase: Bool = false) -> String {
    if !mixedCase { return kotusWordService.randomWord() }
    return Bool.random()
    ? kotusWordService.randomWord()
    : kotusWordService.randomWord().flipCase()
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

  private func wordArrayContainsMixedCase(_ words: [String]) -> Bool {
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
