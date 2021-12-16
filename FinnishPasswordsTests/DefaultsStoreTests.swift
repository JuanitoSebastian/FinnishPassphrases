//
//  DefaultsStoreTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 15.12.2021.
//

@testable import FinnishPasswords
import XCTest

class DefaultsStoreTests: XCTestCase {

    var userDefaults: UserDefaults!
    var defaultsStore: DefaultsStore!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        defaultsStore = DefaultsStore(userDefaults: userDefaults)
    }

    func test_a_store_return_correct_initial_values() {
        XCTAssertEqual(defaultsStore.numberOfWordsInPassphrase, 4)
        XCTAssertEqual(defaultsStore.separatorSymbol, .hyphen)
        XCTAssertEqual(defaultsStore.wordCapitalization, false)
    }

    func test_b_editing_values_of_store_works() {
        defaultsStore.numberOfWordsInPassphrase = 8
        defaultsStore.separatorSymbol = .asterisk
        defaultsStore.wordCapitalization = true

        XCTAssertEqual(defaultsStore.numberOfWordsInPassphrase, 8)
        XCTAssertEqual(defaultsStore.separatorSymbol, .asterisk)
        XCTAssertEqual(defaultsStore.wordCapitalization, true)
    }
}
