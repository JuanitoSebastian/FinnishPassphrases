//
//  KotusWordServiceTests.swift
//  FinnishPasswordsTests
//
//  Created by Juan Covarrubias on 15.12.2021.
//

@testable import FinnishPasswords
import XCTest

class KotusWordServiceTests: XCTestCase {

    var kotusWordService: KotusWordService?
    let correctWords = ["ahdasrajaisesti", "ahdasrajaisuus", "ahdata", "ahde", "ahdekaunokki"]
    let customData = """
        <st><s>ahdasrajaisesti</s><t><tn>99</tn></t></st>
        <st><s>ahdasrajaisuus</s><t><tn>40</tn></t></st>
        <st><s>ahdata</s><t><tn>73</tn><av>F</av></t></st>
        <st><s>ahde</s><t><tn>48</tn><av>F</av></t></st>
        <st><s>ahdekaunokki</s></st>
        """

    override func setUp() {
        kotusWordService = KotusWordService(customData: customData)
        kotusWordService!.readFileToMemory()
    }

    func test_a_check_that_correct_word_is_generated() throws {
        let word = kotusWordService!.randomWord()
        XCTAssertTrue(correctWords.contains(word))
    }

}
