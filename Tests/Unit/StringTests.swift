//
//  StringTests.swift
//  FinnishPassphrasesTests
//
//  Created by Juan Covarrubias on 18.2.2022.
//

@testable import Finnish_Passphrases
import XCTest

class StringTests: XCTestCase {

    func test_a_lowercase_string_to_uppercase_is_returned_correctly() {
        let lowerCaseString = "kirsikka"
        let flipped = lowerCaseString.flipCase()
        flipped.forEach { letter in
            XCTAssertTrue(letter.isUppercase)
        }
    }

    func test_b_uppercase_string_to_lowercase_is_returned_correctly() {
        let upperCaseString = "KIRSIKKA"
        let flipped = upperCaseString.flipCase()
        flipped.forEach { letter in
            XCTAssertTrue(letter.isLowercase)
        }
    }

}
