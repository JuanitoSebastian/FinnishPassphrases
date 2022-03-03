//
//  BasicOperationTests.swift
//  Finnish PassphrasesEndToEndTests
//
//  Created by Juan Covarrubias on 2.3.2022.
//

import XCTest

class BasicOperationTests: XCTestCase {

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

  func test_a_about_window_is_displayed() throws {
    XCTAssert(aboutWindow!.element.exists)
    XCTAssert(aboutWindow!.element.isHittable)
    XCTAssert(aboutWindowContents!.text.element.exists)
  }

  func test_b_about_window_can_be_closed() throws {
    aboutWindowContents!.closeButton.element.click()
    XCTAssertFalse(aboutWindow!.element.isHittable)
  }

  func test_c_pop_over_can_be_opened() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon!.element.click()
    sleep(1)

    XCTAssert(popOverContents!.quitButton.element.exists)
    XCTAssert(popOverContents!.quitButton.element.isHittable)
    XCTAssert(popOverContents!.aboutButton.element.exists)
    XCTAssert(popOverContents!.aboutButton.element.isHittable)
    XCTAssert(popOverContents!.copyButton.element.exists)
    XCTAssert(popOverContents!.copyButton.element.isHittable)
    XCTAssert(popOverContents!.newButton.element.exists)
    XCTAssert(popOverContents!.newButton.element.isHittable)
    XCTAssert(popOverContents!.passphraseArea.element.exists)
  }

  func test_d_quit_button_works_as_expected() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    popOverContents!.quitButton.element.click()
    XCTAssertFalse(menuBarIcon.element.exists)
  }

  func test_e_about_button_works_as_expected() throws {
    aboutWindowContents!.closeButton.element.click()
    XCTAssertFalse(aboutWindow!.element.isHittable)
    menuBarIcon.element.click()
    sleep(1)

    popOverContents!.aboutButton.element.click()
    XCTAssert(aboutWindow!.element.isHittable)
  }

  func test_f_copy_button_works_as_expected() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    popOverContents!.copyButton.element.click()
    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    let pasteboard = NSPasteboard.general
    let pasteboardContents = pasteboard.pasteboardItems![0]
      .string(forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
    XCTAssertEqual(currentPassphrase, pasteboardContents)
    XCTAssertEqual(currentPassphrase, getPassphraseFromElement(popOverContents!.passphraseArea))
  }

  func test_g_new_button_works_as_expected() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    sleep(1)

    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    popOverContents!.newButton.element.click()
    XCTAssertNotEqual(currentPassphrase, getPassphraseFromElement(popOverContents!.passphraseArea))
  }

  func test_h_closing_and_reopening_pop_over_generates_new_passphrase() throws {
    aboutWindowContents!.closeButton.element.click()
    menuBarIcon.element.click()
    let currentPassphrase = getPassphraseFromElement(popOverContents!.passphraseArea)
    sleep(1)
    menuBarIcon.element.click()
    sleep(1)
    menuBarIcon.element.click()
    sleep(1)
    XCTAssertNotEqual(currentPassphrase, getPassphraseFromElement(popOverContents!.passphraseArea))
  }
}
