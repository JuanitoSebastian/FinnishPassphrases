//
//  PassphraseGeneratorServiceTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 16.12.2021.
//

@testable import FinnishPasswords
import XCTest
import Mockingbird

class PassphraseGeneratorServiceTests: XCTestCase {

    var passphraseGeneratorService: PassphraseGeneratorService!
    var kotusWordServiceMock: KotusWordServiceMock!

    override func setUp() {
        self.kotusWordServiceMock = mock(KotusWordService.self)
            .initialize(nameOfXmlFile: "", customData: "")
        self.passphraseGeneratorService = PassphraseGeneratorService(
            kotusWordService: kotusWordServiceMock
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

        passphrase = passphraseGeneratorService.updatePassphraseWordCapitalization(
            passphrase: passphrase,
            wordCapitalization: false
        )

        XCTAssertEqual(passphrase.passphrase, "karpalo*kukka*tiekyltti")
    }
}
