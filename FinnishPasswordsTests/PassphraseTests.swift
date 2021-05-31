//
//  FinnishPasswordsTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 31.5.2021.
//

@testable import FinnishPasswords
import XCTest

class PassphraseTests: XCTestCase {

    func test_passphrase_returns_correct_string() {
        let passphrase = Passphrase(
            words: ["yksi", "kaksi", "kolme"],
            separator: .hash
        )
        XCTAssertEqual(passphrase.passphrase, "yksi#kaksi#kolme")
        XCTAssertEqual(passphrase.numOfCharacters, 16)
        XCTAssertEqual(passphrase.numOfWords, 3)
    }

}
