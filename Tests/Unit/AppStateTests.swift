//
//  AppStateTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 18.12.2021.
//

@testable import Finnish_Passphrases
import XCTest
import Mockingbird

class AppStateTests: XCTestCase {

  var pasteboard: NSPasteboard!
  var defaultStore: Store!
  var wordService: WordService!
  var passsphraseGenerator: PassphraseGeneratorService!
  var appState: AppState!

  override func setUp() {
    self.pasteboard = NSPasteboard.general
    self.defaultStore = TestingStore()
    self.wordService = TestingWordService()
    self.passsphraseGenerator = PassphraseGeneratorService(
      wordService: wordService
    )
    self.appState = AppState(
      passphraseGeneratorService: passsphraseGenerator,
      defaultsStore: defaultStore,
      pasteboard: pasteboard
    )
  }

  func test_a_appstate_is_initialized_correctly() {
    XCTAssertEqual(appState.passphrase.separator, defaultStore.separatorSymbol)
    XCTAssertEqual(appState.passphrase.numOfWords, defaultStore.numberOfWords)
    XCTAssertFalse(appState.capitalization)

    for word in appState.passphrase.words {
      XCTAssertTrue(cTestingWords.contains(word))
    }
  }

  func test_b_setting_number_of_words_works() {
    appState.numOfWords = 5
    XCTAssertEqual(defaultStore.numberOfWords, 5)
    XCTAssertEqual(appState.numOfWords, 5)
    appState.generateNewPassphrase()

    XCTAssertEqual(appState.passphrase.numOfWords, 5)
  }

  func test_c_setting_number_of_words_to_same_does_notghing() {
    let currentNumber = appState.numOfWords
    appState.numOfWords = currentNumber

    XCTAssertEqual(defaultStore.numberOfWords, currentNumber)

    appState.generateNewPassphrase()

    XCTAssertEqual(appState.passphrase.numOfWords, currentNumber)
  }

  func test_d_setting_separator_works() {
    appState.separator = .slash
    XCTAssertEqual(defaultStore.separatorSymbol, .slash)
    XCTAssertEqual(appState.separator, .slash)
    appState.generateNewPassphrase()

    XCTAssertEqual(appState.passphrase.separator, .slash)
  }

  func test_e_setting_separator_to_same_does_nothing() {
    let currentSeparator = appState.separator
    appState.separator = currentSeparator

    XCTAssertEqual(defaultStore.separatorSymbol, currentSeparator)

    appState.generateNewPassphrase()

    XCTAssertEqual(appState.passphrase.separator, currentSeparator)
  }

  func test_f_copying_to_pasteboard_works() {
    appState.copyPassphraseToPasteboard()

    let textFromPastebaord = pasteboard.pasteboardItems![0]
      .string(forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))

    XCTAssertEqual(textFromPastebaord, appState.passphrase.passphrase)
  }

  func test_g_display_about_window_calls_function() {
    var testBool = false

    func mock() {
      testBool = true
    }

    appState.openAboutWindow = mock
    appState.displayAboutWindow()
    XCTAssertTrue(testBool)
  }

  func test_h_setting_capitalization_works_correctly() {
    XCTAssertFalse(defaultStore.mixedCase)

    appState.capitalization = true
    XCTAssertTrue(defaultStore.mixedCase)
    XCTAssertTrue(appState.capitalization)

    appState.generateNewPassphrase()

    var upperCase = false
    for word in appState.passphrase.words {
      if word.first?.isUppercase != nil && word.first!.isUppercase {
        upperCase = true
      }
    }

    XCTAssertTrue(upperCase)
  }

}
