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

    private func randomizeStringCase(_ word: String) -> String {
        var newWord = word
        if Double.random(in: 0...1) > 0.7 { newWord = newWord.uppercased() }
        return newWord
    }
}
