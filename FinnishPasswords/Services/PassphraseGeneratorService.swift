//
//  PasswordGeneratorService.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 19.5.2021.
//

import Foundation

class PassphraseGeneratorService: ObservableObject {

    let kotusWordService: KotusWordService
    @Published var passphrase: Passphrase?

    init(kotusWordService: KotusWordService) {
        self.kotusWordService = kotusWordService
        self.passphrase = nil
        generatePassphrase()
    }
}

// MARK: - Functions
extension PassphraseGeneratorService {

    func generatePassphrase() {
        var words: [String] = []

        for _ in 0..<DefaultsStore.shared.numberOfWordsInPassphrase {
            words.append(randomizeStringCase(kotusWordService.randomWord()))
        }

        passphrase = Passphrase(words: words, separator: DefaultsStore.shared.separatorSymbol)

    }

    func replaceWordAtIndex(_ index: Int) {
        guard let passphrase = passphrase else { return }
        var words = passphrase.words
        words[index] = randomizeStringCase(kotusWordService.randomWord())
        self.passphrase = Passphrase(words: words, separator: passphrase.separator)
    }

    func flipCaseOfWordAtIndex(_ index: Int) {
        guard let passphrase = passphrase else { return }
        var words = passphrase.words
        words[index] = words[index].flipCase()
        self.passphrase = Passphrase(words: words, separator: passphrase.separator)
    }

    func flipCaseOfCharAtIndex(wordIndex: Int, index: Int) {
        guard let passphrase = passphrase else { return }
        var stringArray = passphrase.words
        var wordArray = Array(stringArray[wordIndex])
        wordArray[index] = wordArray[index].flipCase()
        stringArray[wordIndex] = String(wordArray)
        self.passphrase = Passphrase(words: stringArray, separator: passphrase.separator)
    }

    func flipCaseOfCharAtIndex(_ index: Int) {
        guard let passphrase = passphrase else { return }
        guard index < passphrase.numOfCharacters else { return }

        var charactersSoFar = 0
        var wordIndex = -1
        for word in passphrase.words {
            charactersSoFar += word.count
            wordIndex += 1

            if index < charactersSoFar {

                break
            }
        }
        
    }

    private func randomizeStringCase(_ word: String) -> String {
        var newWord = word
        if Double.random(in: 0...1) > 0.7 { newWord = newWord.uppercased() }
        return newWord
    }
}
