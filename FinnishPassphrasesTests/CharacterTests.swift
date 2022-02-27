//
//  CharacterTests.swift
//  FinnishPassphrasesTests
//
//  Created by Juan Covarrubias on 18.2.2022.
//

@testable import Finnish_Passphrases
import XCTest

class CharacterTests: XCTestCase {

    func test_a_lowercase_character_is_flipped_to_uppercase() {
        let lowercase: Character = "a"
        let flipped = lowercase.flipCase()
        XCTAssertTrue(flipped.isUppercase)
        XCTAssertEqual(flipped.flipCase(), lowercase)
    }

    func test_b_uppercase_character_is_flipped_to_lowercase() {
        let uppercase: Character = "A"
        let flipped = uppercase.flipCase()
        XCTAssertTrue(flipped.isLowercase)
        XCTAssertEqual(flipped.flipCase(), uppercase)
    }
}
