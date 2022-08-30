//
//  AppState.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 18.5.2021.
//

import Foundation
import Combine
import AppKit

/// AppState is class that contains the current state of the application. UI actions always call AppState.
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

  private var defaultsStore: Store
  private let passphraseGeneratorService: PassphraseGeneratorService
  var openAboutWindow: (() -> Void)?

  init(
    passphraseGeneratorService: PassphraseGeneratorService = PassphraseGeneratorService(),
    defaultsStore: Store = DefaultsStore()
  ) {
    self.defaultsStore = defaultsStore
    self.passphraseGeneratorService = passphraseGeneratorService
    self.capitalization = defaultsStore.mixedCase
    self.separator = defaultsStore.separatorSymbol
    self.numOfWords = defaultsStore.numberOfWords
    self.passphrase = passphraseGeneratorService.generatePassphrase(
      numOfWords: defaultsStore.numberOfWords,
      separatorSymbol: defaultsStore.separatorSymbol,
      wordCapitalization: defaultsStore.mixedCase
    )
  }

}

// MARK: - Computed Variables
extension AppState {
  var appVersion: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
  }

  private var pasteboard: NSPasteboard {
    let board = NSPasteboard.general
    board.declareTypes([.string], owner: nil)
    return board
  }
}

// MARK: - Functions
extension AppState {

  /// Generates a new Passphrase using the current settings
  /// stored in DefaultsStore
  func generateNewPassphrase() {
    passphrase = passphraseGeneratorService.generatePassphrase(
      numOfWords: defaultsStore.numberOfWords,
      separatorSymbol: defaultsStore.separatorSymbol,
      wordCapitalization: defaultsStore.mixedCase
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
  /// - Parameter valueToSet: The capitalization preference to set
  private func handleChangeOfCapitalization(_ valueToSet: Bool) {
    defaultsStore.mixedCase = valueToSet
    passphrase = passphraseGeneratorService.updatePassphraseWordCapitalization(
      passphrase: passphrase,
      wordCapitalization: valueToSet
    )
  }

  /// Sets the SeparatorSymbol that will be used to generate Passphrase.
  /// - Parameter separator: The separator symbol to set
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

    defaultsStore.numberOfWords = numberOfWordToSet
    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(
      passphrase: passphrase, numOfWords: numberOfWordToSet
    )
  }

}
