//
//  PassphraseGeneratorServiceTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 16.12.2021.
//

@testable import Finnish_Passphrases
import XCTest
import Mockingbird

class PassphraseGeneratorServiceTests: XCTestCase {

  var passphraseGeneratorService: PassphraseGeneratorService!
  var kotusWordServiceMock: KotusWordServiceMock!

  override func setUp() {
    self.kotusWordServiceMock = mock(KotusWordService.self)
      .initialize(nameOfXmlFile: "")
    self.passphraseGeneratorService = PassphraseGeneratorService(
      wordService: kotusWordServiceMock
    )
  }

  func test_a_generate_passphrase_returns_valid_passphrase() {
    given(kotusWordServiceMock.randomWord())
      .willReturn("kirjolohi")
      .willReturn("kahvikuppi")
      .willReturn("kipinä")

    let passphrase = passphraseGeneratorService.generatePassphrase(
      numOfWords: 3, separatorSymbol: .hash, wordCapitalization: false
    )

    verify(kotusWordServiceMock.randomWord()).wasCalled(3)

    XCTAssertEqual(passphrase.numOfWords, 3)
    XCTAssertEqual(passphrase.passphrase, "kirjolohi#kahvikuppi#kipinä")
  }

  func test_b_updating_passphrase_separator_returns_valid_passphrase() {
    var passphrase = Passphrase(
      words: ["karpalo", "kukka", "tiekyltti"],
      separator: .asterisk
    )

    passphrase = passphraseGeneratorService.updatePassphraseSeparatorSymbol(
      passphrase: passphrase,
      separatorSymbol: .slash
    )

    XCTAssertEqual(passphrase.separator, .slash)
    XCTAssertEqual(passphrase.passphrase, "karpalo/kukka/tiekyltti")
    XCTAssertEqual(passphrase.mixedCase, false)
  }

  func test_c_updating_passphrase_capitalization_returns_valid_passphrase() {
    var passphrase = Passphrase(
      words: ["karpalo", "kukka", "tiekyltti"],
      separator: .asterisk
    )

    passphrase = passphraseGeneratorService.updatePassphraseWordCapitalization(
      passphrase: passphrase,
      wordCapitalization: true
    )

    XCTAssertEqual(passphrase.passphrase.lowercased(), "karpalo*kukka*tiekyltti")
    XCTAssertNotEqual(passphrase.passphrase, "karpalo*kukka*tiekyltti")
    XCTAssertEqual(passphrase.mixedCase, true)

    passphrase = passphraseGeneratorService.updatePassphraseWordCapitalization(
      passphrase: passphrase,
      wordCapitalization: false
    )

    XCTAssertEqual(passphrase.passphrase, "karpalo*kukka*tiekyltti")
    XCTAssertEqual(passphrase.mixedCase, false)
  }

  func test_d_updating_passphrase_numofwords_equal_returns_same_passphrase() {
    let passphraseOriginal = Passphrase(
      words: ["karpalo", "kukka", "tiekyltti"],
      separator: .asterisk
    )

    let passphraseNew = passphraseGeneratorService.updatePassphraseNumOfWords(
      passphrase: passphraseOriginal,
      numOfWords: 3
    )

    XCTAssertEqual(passphraseOriginal, passphraseNew)
  }

  func test_d_updating_passphrase_numofwords_to_greater_returns_valid_passphrase() {
    var passphrase = Passphrase(
      words: ["karpalo", "kukka", "tiekyltti"],
      separator: .asterisk
    )

    given(kotusWordServiceMock.randomWord())
      .willReturn("kirjolohi")
      .willReturn("kahvikuppi")
      .willReturn("kipinä")

    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(
      passphrase: passphrase,
      numOfWords: 6
    )

    verify(kotusWordServiceMock.randomWord()).wasCalled(3)

    XCTAssertEqual(passphrase.passphrase, "karpalo*kukka*tiekyltti*kirjolohi*kahvikuppi*kipinä")
  }

  func test_e_updating_passphrase_numofwords_to_lesser_returns_valid_passphrase() {
    var passphrase = Passphrase(
      words: ["karpalo", "kukka", "tiekyltti", "kirjolohi", "kahvikuppi", "kipinä"],
      separator: .asterisk
    )

    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(passphrase: passphrase, numOfWords: 3)

    XCTAssertEqual(passphrase.passphrase, "karpalo*kukka*tiekyltti")
  }

  func test_f_updating_passphrase_numofwords_to_lesser_returns_valid_passphrase_mixed_case() {
    let wordsToUse = ["kirnupiimä", "kansantasavalta", "astevaihtu", "KAARNA", "tikku", "PALKKA"]
    var passphrase = Passphrase(
      words: wordsToUse,
      separator: .asterisk
    )

    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(passphrase: passphrase, numOfWords: 5)
    XCTAssertEqual(passphrase.words, Array(wordsToUse[...4]))

    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(passphrase: passphrase, numOfWords: 4)
    XCTAssertEqual(passphrase.words, Array(wordsToUse[...3]))

    // Removing the last capitalized word
    passphrase = passphraseGeneratorService.updatePassphraseNumOfWords(passphrase: passphrase, numOfWords: 3)
    XCTAssertNotEqual(passphrase.words, Array(wordsToUse[...2]))

    // Confirm that one of the three words left has been capitalized to keep Passphrase mixed case
    var upperCase = false
    for word in passphrase.words {
      if word.first?.isUppercase != nil && word.first!.isUppercase {
        upperCase = true
      }
    }
    XCTAssertTrue(upperCase)
  }
}
