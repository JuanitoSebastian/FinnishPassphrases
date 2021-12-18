//
//  AppState.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 18.5.2021.
//

import Foundation
import Combine
import AppKit

class AppState: ObservableObject {

    @Published var passphrase: Passphrase
    @Published var capitalization: Bool {
        didSet {
            handleChangeOfCapitalization(capitalization)
        }
    }

    private let defaultsStore: DefaultsStore
    private let passphraseGeneratorService: PassphraseGeneratorService
    private let pasteboard: NSPasteboard

    init() {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        self.defaultsStore = DefaultsStore()
        self.passphraseGeneratorService = PassphraseGeneratorService(
            kotusWordService: kotusWordService
        )
        self.capitalization = defaultsStore.wordCapitalization
        self.pasteboard = NSPasteboard.general
        self.pasteboard.declareTypes([.string], owner: nil)
        self.passphrase = passphraseGeneratorService.generatePassphrase(
            numOfWords: defaultsStore.numberOfWordsInPassphrase,
            separatorSymbol: defaultsStore.separatorSymbol,
            wordCapitalization: defaultsStore.wordCapitalization
        )
    }

}

// MARK: - Computed varibales
extension AppState {
    var separatorSymbol: SeparatorSymbol {
        defaultsStore.separatorSymbol
    }

    var numberOfWordsInPassphrase: Int {
        defaultsStore.numberOfWordsInPassphrase
    }
}

// MARK: - Functions
extension AppState {
    func generatePassphrase() {
        passphrase = passphraseGeneratorService.generatePassphrase(
            numOfWords: defaultsStore.numberOfWordsInPassphrase,
            separatorSymbol: defaultsStore.separatorSymbol,
            wordCapitalization: defaultsStore.wordCapitalization
        )
    }

    func copyToPasteboard() {
        pasteboard.setString(passphrase.passphrase, forType: .string)
    }

    func decrementNumberOfWordsInPassphrase() {
        guard defaultsStore.numberOfWordsInPassphrase > cMinimumNumberOfWordsInPassphrase else { return }
        defaultsStore.numberOfWordsInPassphrase -= 1
    }

    func incrementNumberOfWordsInPassphrase() {
        defaultsStore.numberOfWordsInPassphrase += 1
    }

    func setNumberOfWordsInPassphrase(_ numberOfWordToSet: Int) {
        guard numberOfWordToSet >= cMinimumNumberOfWordsInPassphrase
                && numberOfWordToSet <= cMaximumNumberOfWordsInPassphrase else {
            return
        }

        defaultsStore.numberOfWordsInPassphrase = numberOfWordToSet
    }

    func setCurrentSeparator(_ separator: SeparatorSymbol) {
        defaultsStore.separatorSymbol = separator
        passphrase = passphraseGeneratorService.updatePassphraseSeparatorSymbol(
            passphrase: passphrase,
            separatorSymbol: separator
        )
    }

    func quitApplication() {
        NSApplication.shared.terminate(self)
    }
}

// MARK: - Private Functions
extension AppState {

    /// This function is called whenever the UI changes the value of the capitalization variable here in the AppState.
    /// This function stores the user preference of capitalization in DefaultsStore and
    /// calls the PasssphraseGeneratorService to update the passphrase
    private func handleChangeOfCapitalization(_ valueToSet: Bool) {
        defaultsStore.wordCapitalization = valueToSet
        passphrase = passphraseGeneratorService.updatePassphraseWordCapitalization(
            passphrase: passphrase,
            wordCapitalization: valueToSet
        )
    }

}
