//
//  DefaultsStoreTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 15.12.2021.
//

@testable import FinnishPassphrases
import XCTest

class DefaultsStoreTests: XCTestCase {

    var userDefaults: UserDefaults!
    var defaultsStore: DefaultsStore!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        defaultsStore = DefaultsStore(userDefaults: userDefaults)
    }

    func test_a_editing_values_of_store_works() {
        defaultsStore.numberOfWordsInPassphrase = 8
        defaultsStore.separatorSymbol = .asterisk
        defaultsStore.wordCapitalization = true

        XCTAssertEqual(defaultsStore.numberOfWordsInPassphrase, 8)
        XCTAssertEqual(defaultsStore.separatorSymbol, .asterisk)
        XCTAssertEqual(defaultsStore.wordCapitalization, true)
    }

}
