//
//  AppStateTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 18.12.2021.
//

@testable import FinnishPasswords
import XCTest
import Mockingbird

class AppStateTests: XCTestCase {

    var pasteboard: NSPasteboard!
    var defaultsStoreMock: DefaultsStoreMock!
    var passphraseGeneratorMock: PassphraseGeneratorServiceMock!
    var appState: AppState!

    override func setUp() {

        let customData = """
        <st><s>ahdasrajaisesti</s><t><tn>99</tn></t></st>
        <st><s>ahdasrajaisuus</s><t><tn>40</tn></t></st>
        <st><s>ahdata</s><t><tn>73</tn><av>F</av></t></st>
        <st><s>ahde</s><t><tn>48</tn><av>F</av></t></st>
        <st><s>ahdekaunokki</s></st>
        """

        self.defaultsStoreMock = mock(DefaultsStore.self).initialize(
            userDefaults: UserDefaults(suiteName: #file)!
        )
        self.passphraseGeneratorMock = mock(PassphraseGeneratorService.self).initialize(
            kotusWordService: KotusWordService(customData: customData)
        )

        self.pasteboard = NSPasteboard.general
    }

    func test_a_appstate_is_initialized_correctly() {
//        given(defaultsStoreMock.numberOfWordsInPassphrase)
//            .willReturn(3)
//        given(defaultsStoreMock.separatorSymbol)
//            .willReturn(.hyphen)
//        given(defaultsStoreMock.wordCapitalization)
//            .willReturn(false)
//
//        let passphraseToReturn = Passphrase(
//            words: ["ahven", "kirjolohi", "saapas"],
//            separator: .hyphen
//        )
//
//        given(passphraseGeneratorMock.generatePassphrase(
//            numOfWords: 3,
//            separatorSymbol: .hyphen,
//            wordCapitalization: false
//        )).willReturn(passphraseToReturn)
//
//        appState = AppState(
//            passphraseGeneratorService: passphraseGeneratorMock,
//            defaultsStore: defaultsStoreMock,
//            pasteboard: pasteboard
//        )
//
//        XCTAssertEqual(appState.passphrase, passphraseToReturn)
    }

}

// MARK: - Supporting functions
extension AppStateTests {
    private func initializeAppState() {
        self.appState = AppState(
            passphraseGeneratorService: passphraseGeneratorMock,
            defaultsStore: defaultsStoreMock,
            pasteboard: pasteboard
        )
    }
}
