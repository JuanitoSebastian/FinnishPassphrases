//
//  SeparatorSymbolTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 31.5.2021.
//

@testable import FinnishPassphrases
import XCTest

class SeparatorSymbolTests: XCTestCase {

    func test_a_correct_symbol_is_returned() {
        XCTAssertEqual(SeparatorSymbol.asterisk.symbol, "*")
        XCTAssertEqual(SeparatorSymbol.hash.symbol, "#")
        XCTAssertEqual(SeparatorSymbol.slash.symbol, "/")
        XCTAssertEqual(SeparatorSymbol.hyphen.symbol, "-")
    }

    func test_b_correct_name_is_returned() {
        XCTAssertEqual(SeparatorSymbol.asterisk.name, "Asterisk")
        XCTAssertEqual(SeparatorSymbol.hash.name, "Hash")
        XCTAssertEqual(SeparatorSymbol.slash.name, "Slash")
        XCTAssertEqual(SeparatorSymbol.hyphen.name, "Hyphen")
    }

    func test_c_correct_id_is_returned() {
        XCTAssertEqual(SeparatorSymbol.asterisk.id, SeparatorSymbol.asterisk.rawValue)
        XCTAssertEqual(SeparatorSymbol.hash.id, SeparatorSymbol.hash.rawValue)
        XCTAssertEqual(SeparatorSymbol.slash.id, SeparatorSymbol.slash.rawValue)
        XCTAssertEqual(SeparatorSymbol.hyphen.id, SeparatorSymbol.hyphen.rawValue)
    }

}
