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
  @Published var separator: SeparatorSymbol {
    didSet {
      handleChangeOfSeparatorSymbol(separator)
    }
  }
  @Published var numOfWords: Int {
    didSet {
      handleChangeOfNumberOfWords(numOfWords)
    }
  }

  private let defaultsStore: DefaultsStore
  private let passphraseGeneratorService: PassphraseGeneratorService
  private let pasteboard: NSPasteboard
  var openAboutWindow: (() -> Void)?

  init(
    passphraseGeneratorService: PassphraseGeneratorService,
    defaultsStore: DefaultsStore = DefaultsStore(),
    pasteboard: NSPasteboard = NSPasteboard.general
  ) {
    self.defaultsStore = defaultsStore
    self.passphraseGeneratorService = passphraseGeneratorService
    self.capitalization = defaultsStore.wordCapitalization
    self.separator = defaultsStore.separatorSymbol
    self.numOfWords = defaultsStore.numberOfWordsInPassphrase
    self.pasteboard = pasteboard
    self.pasteboard.declareTypes([.string], owner: nil)
    self.passphrase = passphraseGeneratorService.generatePassphrase(
      numOfWords: defaultsStore.numberOfWordsInPassphrase,
      separatorSymbol: defaultsStore.separatorSymbol,
      wordCapitalization: defaultsStore.wordCapitalization
    )
  }

}

// MARK: - Computed Variables
extension AppState {
  var appVersion: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
  }
}

// MARK: - Functions
extension AppState {

  /// Generates a new Passphrase using the current settings
  /// stored in DefaultsStore
  func generateNewPassphrase() {
    passphrase = passphraseGeneratorService.generatePassphrase(
      numOfWords: defaultsStore.numberOfWordsInPassphrase,
      separatorSymbol: defaultsStore.separatorSymbol,
      wordCapitalization: defaultsStore.wordCapitalization
    )
  }

  /// Copies the currect Passphrase to the system pasteboard
  func copyPassphraseToPasteboard() {
    pasteboard.setString(passphrase.passphrase, forType: .string)
  }

  /// Opens the About window. Calls the function injected from the AppDelefate
  func displayAboutWindow() {
    openAboutWindow?()
  }

  /// Quits the whole application
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

  /// Sets the SeparatorSymbol that will be used to generate Passphrase.
  private func handleChangeOfSeparatorSymbol(_ separator: SeparatorSymbol) {
    defaultsStore.separatorSymbol = separator
    passphrase = passphraseGeneratorService.updatePassphraseSeparatorSymbol(
      passphrase: passphrase,
      separatorSymbol: separator
    )
  }

  /// Sets the  number of words in a Passphrase. Function checks that
  /// the given number is within accepted range. If number is not in range, nothing
  /// is done.
  /// - Parameter numberOfWordsToSet: The number of words in Passphrase
  private func handleChangeOfNumberOfWords(_ numberOfWordToSet: Int) {
    guard cPassphraseNumberOfWordsRangeInt.contains(numberOfWordToSet) else {
      return
    }

    defaultsStore.numberOfWordsInPassphrase = numberOfWordToSet
    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(
      passphrase: passphrase, numOfWords: numberOfWordToSet
    )
  }

}
