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
    var defaultsStoreMock: DefaultsStoreMock!
    var kotusWordServiceMock: KotusWordServiceMock!

    override func setUp() {
        self.defaultsStoreMock = mock(DefaultsStore.self)
            .initialize(userDefaults: UserDefaults(suiteName: #file)!)
        self.kotusWordServiceMock = mock(KotusWordService.self)
            .initialize(nameOfXmlFile: "", customData: "")
        self.passphraseGeneratorService = PassphraseGeneratorService(
            kotusWordService: kotusWordServiceMock,
            defaultsStore: defaultsStoreMock
        )
    }

    func test_a_word_arrays_generated_correctly() {
        given(kotusWordServiceMock.randomWord())
            .willReturn("kirjolohi")
            .willReturn("kahvikuppi")
            .willReturn("kipinä")

        given(defaultsStoreMock.separatorSymbol)
            .willReturn(.hash)

        given(defaultsStoreMock.wordCapitalization)
            .willReturn(false)

        given(defaultsStoreMock.numberOfWordsInPassphrase)
            .willReturn(3)

        passphraseGeneratorService.generatePassphrase()

        verify(kotusWordServiceMock.randomWord()).wasCalled(3)
        verify(defaultsStoreMock.separatorSymbol).wasCalled(1)
        verify(defaultsStoreMock.wordCapitalization).wasCalled(1)
        verify(defaultsStoreMock.numberOfWordsInPassphrase).wasCalled(1)

        let passphrase = passphraseGeneratorService.passphrase!

        XCTAssertEqual(passphrase.numOfWords, 3)
        XCTAssertEqual(passphrase.passphrase, "kirjolohi#kahvikuppi#kipinä")
    }
}
