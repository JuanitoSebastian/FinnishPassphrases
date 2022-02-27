//
//  FinnishPasswordsTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 31.5.2021.
//

@testable import Finnish_Passphrases
import XCTest

class PassphraseTests: XCTestCase {

    let passphraseLowerCase = Passphrase(
        words: ["yksi", "kaksi", "kolme"],
        separator: .hash
    )

    let passphraseUpperCase = Passphrase(
        words: ["nallukka", "PAARMA", "MUME", "TILKKA"],
        separator: .asterisk
    )

    func test_a_passphrase_returns_correct_computed_variables() {
        XCTAssertEqual(passphraseLowerCase.passphrase, "yksi#kaksi#kolme")
        XCTAssertEqual(passphraseLowerCase.numOfCharacters, 16)
        XCTAssertEqual(passphraseLowerCase.numOfWords, 3)
        XCTAssertFalse(passphraseLowerCase.mixedCase)
    }

    func test_b_passphrase_returns_correct_computed_variables() {
        XCTAssertEqual(passphraseUpperCase.passphrase, "nallukka*PAARMA*MUME*TILKKA")
        XCTAssertTrue(passphraseUpperCase.mixedCase)
        XCTAssertEqual(passphraseUpperCase.numOfCharacters, 27)
        XCTAssertEqual(passphraseUpperCase.numOfWords, 4)
    }

    func test_c_check_equatable_works_correctly() {
        XCTAssertTrue(passphraseUpperCase == passphraseUpperCase)
        XCTAssertFalse(passphraseUpperCase == passphraseLowerCase)

        let passphraseComparison = Passphrase(
            words: ["yksi", "kaksi", "kolme"],
            separator: .hash
        )

        XCTAssertEqual(passphraseComparison, passphraseLowerCase)
    }

    func test_d_description_is_correct() {
        let expectedDescription =
        """
        Passphrase: nallukka*PAARMA*MUME*TILKKA
        numOfWords: 4
        separator: asterisk
        """
        XCTAssertEqual(expectedDescription, passphraseUpperCase.description)
    }

}
