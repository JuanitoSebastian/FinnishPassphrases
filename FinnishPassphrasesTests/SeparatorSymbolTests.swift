//
//  SeparatorSymbolTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 31.5.2021.
//

@testable import FinnishPassphrases
import XCTest

class SeparatorSymbolTests: XCTestCase {

    func test_correct_symbol_is_returned() {
        XCTAssertEqual(SeparatorSymbol.asterisk.symbol, "*")
        XCTAssertEqual(SeparatorSymbol.hash.symbol, "#")
        XCTAssertEqual(SeparatorSymbol.slash.symbol, "/")
        XCTAssertEqual(SeparatorSymbol.hyphen.symbol, "-")
    }

}
