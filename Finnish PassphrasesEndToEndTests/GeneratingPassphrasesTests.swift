//
//  GeneratingPassphrasesTests.swift
//  Finnish PassphrasesEndToEndTests
//
//  Created by Juan Covarrubias on 3.3.2022.
//

import XCTest

class GeneratingPassphrasesTests: XCTestCase {

  var app: XCUIApplication!
  var menuBarIcon: XCUIElementQuery!
  var (popOver, popOverContents): (XCUIElementQuery?, PopOverContents?)
  var (aboutWindow, aboutWindowContents): (XCUIElementQuery?, AboutWindowContents?)

  override func setUpWithError() throws {
    app = XCUIApplication()
    app.launchEnvironment = ["env": "test"]
    app!.launch()
    menuBarIcon = app.descendants(matching: .statusItem).matching(identifier: "passwords")
    (popOver, popOverContents) = getPopOverContents(app: app!)
    (aboutWindow, aboutWindowContents) = getAboutWindow(app: app!)
  }

  func test_a_incrementing_number_of_words_produces_longer_passphrase() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    popOverContents!.incrementNumbberOfWordsButton.element.click()

    XCTAssertTrue(currentPassphrase.count < getPassphraseFromElement(popOverContents!.passphraseArea).count)
  }

  func test_b_decrementing_number_of_words_produces_shorter_passphrase() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    popOverContents!.decrementNumebrOfWordsButton.element.click()

    XCTAssertTrue(currentPassphrase.count > getPassphraseFromElement(popOverContents!.passphraseArea).count)
  }

  func test_c_mixed_case_toggle_works_as_expected() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    popOverContents!.mixedCaseToggle.element.click()
    XCTAssertNotEqual(currentPassphrase, getPassphraseFromElement(popOverContents!.passphraseArea))
  }
}
