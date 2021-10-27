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
    @Published var capitalization: Bool = DefaultsStore.shared.wordCapitalization {
        didSet {
            handleChangeOfCapitalization(capitalization)
        }
    }
    private var passphraseGeneratorService: PassphraseGeneratorService
    private let pasteboard: NSPasteboard
    private var cancellablePassphrase: AnyCancellable?

    init() {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        self.passphraseGeneratorService = PassphraseGeneratorService(kotusWordService: kotusWordService)
        self.pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        subscribeToPassphraseGeneratorService()
    }

    private func subscribeToPassphraseGeneratorService() {
        self.cancellablePassphrase =
            passphraseGeneratorService.$passphrase.eraseToAnyPublisher().sink { receivedValue in
            self.passphrase = receivedValue
        }
    }
}

// MARK: - Computed properties
extension AppState {

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
        guard DefaultsStore.shared.numberOfWordsInPassphrase > cMinimumNumberOfWordsInPassphrase else { return }
        DefaultsStore.shared.numberOfWordsInPassphrase -= 1
    }

    func incrementNumberOfWordsInPassphrase() {
        DefaultsStore.shared.numberOfWordsInPassphrase += 1
    }

    func setNumberOfWordsInPassphrase(_ numberOfWordToSet: Int) {
        guard numberOfWordToSet >= cMinimumNumberOfWordsInPassphrase
                && numberOfWordToSet <= cMaximumNumberOfWordsInPassphrase else {
            return
        }
        DefaultsStore.shared.numberOfWordsInPassphrase = numberOfWordToSet
    }

    func setCurrentSeparator(_ separator: SeparatorSymbol) {
        DefaultsStore.shared.separatorSymbol = separator
        passphraseGeneratorService.updatePassphraseSeparatorSymbol()
    }

    func quitApplication() {
        NSApplication.shared.terminate(self)
    }
}

// MARK: - Private Functions
extension AppState {
    private func handleChangeOfCapitalization(_ valueToSet: Bool) {
        DefaultsStore.shared.wordCapitalization = valueToSet
        passphraseGeneratorService.updatePassphraseWordCapitalization()
    }
}
