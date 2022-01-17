//
//  AppStateTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 18.12.2021.
//

@testable import FinnishPassphrases
import XCTest
import Mockingbird

class AppStateTests: XCTestCase {

    var pasteboard: NSPasteboard!
    var defaultStore: DefaultsStore!
    var kotusWordService: KotusWordService!
    var passsphraseGenerator: PassphraseGeneratorService!
    var appState: AppState!
    let correctWords = ["ahdasrajaisesti", "ahdasrajaisuus", "ahdata", "ahde", "ahdekaunokki"]

    override func setUp() {
        let customData = """
            <st><s>ahdasrajaisesti</s><t><tn>99</tn></t></st>
            <st><s>ahdasrajaisuus</s><t><tn>40</tn></t></st>
            <st><s>ahdata</s><t><tn>73</tn><av>F</av></t></st>
            <st><s>ahde</s><t><tn>48</tn><av>F</av></t></st>
            <st><s>ahdekaunokki</s></st>
            """
        self.pasteboard = NSPasteboard.general
        self.defaultStore = DefaultsStore(
            userDefaults: UserDefaults(suiteName: #file)!
        )
        self.kotusWordService = KotusWordService(customData: customData)
        kotusWordService.readFileToMemory()
        self.passsphraseGenerator = PassphraseGeneratorService(
            kotusWordService: kotusWordService
        )
        self.appState = AppState(
            passphraseGeneratorService: passsphraseGenerator,
            defaultsStore: defaultStore,
            pasteboard: pasteboard
        )
    }

    func test_a_appstate_is_initialized_correctly() {
        XCTAssertEqual(appState.passphrase.separator, defaultStore.separatorSymbol)
        XCTAssertEqual(appState.passphrase.numOfWords, defaultStore.numberOfWordsInPassphrase)

        for word in appState.passphrase.words {
            XCTAssertTrue(correctWords.contains(word))
        }
    }

    func test_b_setting_number_of_words_works() {
        appState.numOfWords = 5
        XCTAssertEqual(defaultStore.numberOfWordsInPassphrase, 5)
        XCTAssertEqual(appState.numOfWords, 5)
        appState.generateNewPassphrase()

        XCTAssertEqual(appState.passphrase.numOfWords, 5)
    }

    func test_c_setting_separator_works() {
        appState.separator = .slash
        XCTAssertEqual(defaultStore.separatorSymbol, .slash)
        XCTAssertEqual(appState.separator, .slash)
        appState.generateNewPassphrase()

        XCTAssertEqual(appState.passphrase.separator, .slash)
    }

    func test_d_copying_to_pasteboard_works() {
        appState.copyPassphraseToPasteboard()

        let textFromPastebaord = pasteboard.pasteboardItems![0]
            .string(forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))

        XCTAssertEqual(textFromPastebaord, appState.passphrase.passphrase)
    }

}
