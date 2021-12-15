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

    @Published var passphrase: Passphrase?
    @Published var capitalization: Bool {
        didSet {
            handleChangeOfCapitalization(capitalization)
        }
    }

    private var passphraseGeneratorService: PassphraseGeneratorService
    private let pasteboard: NSPasteboard
    private var cancellablePassphrase: AnyCancellable?
    let defaultsStore: DefaultsStore

    init() {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        self.defaultsStore = DefaultsStore()
        self.passphraseGeneratorService = PassphraseGeneratorService(
            kotusWordService: kotusWordService,
            defaultsStore: self.defaultsStore
        )
        self.capitalization = defaultsStore.wordCapitalization
        self.pasteboard = NSPasteboard.general
        self.pasteboard.declareTypes([.string], owner: nil)
        self.subscribeToPassphraseGeneratorService()
    }

}


// MARK: - Functions
extension AppState {
    func generatePassphrase() {
        passphraseGeneratorService.generatePassphrase()
    }

    func copyToPasteboard() {
        guard let passphrase = passphrase else { return }
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
        passphraseGeneratorService.updatePassphraseSeparatorSymbol()
    }

    func quitApplication() {
        NSApplication.shared.terminate(self)
    }
}

// MARK: - Private Functions
extension AppState {

    /// This function is called whenever the UI changes the value of the capitalization variable here in the AppState.
    /// This function stores the user preference of capitalization in DefaultsStore and calls the PaspshraseGeneratorService to update the passphrase
    private func handleChangeOfCapitalization(_ valueToSet: Bool) {
        defaultsStore.wordCapitalization = valueToSet
        passphraseGeneratorService.updatePassphraseWordCapitalization()
    }

    /// Subscribes to the PassphraseGeneratorServices passphrase publisher.
    /// Whenever the passphrase is updated the new passphrase is fetched to AppState.
    private func subscribeToPassphraseGeneratorService() {
        self.cancellablePassphrase =
            passphraseGeneratorService.$passphrase.eraseToAnyPublisher().sink { receivedValue in
            self.passphrase = receivedValue
        }
    }

}
