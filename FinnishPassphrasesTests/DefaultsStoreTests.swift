//
//  DefaultsStoreTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 15.12.2021.
//

@testable import Finnish_Passphrases
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
        defaultsStore.numberOfWords = 8
        defaultsStore.separatorSymbol = .asterisk
        defaultsStore.mixedCase = true

        XCTAssertEqual(defaultsStore.numberOfWords, 8)
        XCTAssertEqual(defaultsStore.separatorSymbol, .asterisk)
        XCTAssertEqual(defaultsStore.mixedCase, true)
    }

}
