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

  func test_d_quit_button_works() throws {
    aboutWindowContents?.closeButton.element.click()
    menuBarIcon.element.click()
    print(app!.state.rawValue)
    sleep(1)

    popOverContents!.quitButton.element.click()
    XCTAssertFalse(menuBarIcon.element.exists)
  }

}

extension BasicOperationTests {
  func getAboutWindow(app: XCUIApplication) -> (XCUIElementQuery, AboutWindowContents) {
    let aboutWindow = app.descendants(matching: .window).matching(identifier: "aboutWindow")
    let aboutWindowContents = AboutWindowContents(
      closeButton: aboutWindow.descendants(matching: .button).matching(identifier: "_XCUI:CloseWindow"),
      text: aboutWindow.descendants(matching: .staticText)
    )
    return (aboutWindow, aboutWindowContents)
  }

  func getPopOverContents(app: XCUIApplication)
  -> (popOver: XCUIElementQuery, popOverContents: PopOverContents) {
    let popOver = app.descendants(matching: .other).matching(identifier: "PopOver")
    let popOverContents = PopOverContents(
      quitButton: popOver.descendants(matching: .button).matching(identifier: "quitButton"),
      aboutButton: popOver.descendants(matching: .button).matching(identifier: "aboutButton"),
      copyButton: popOver.descendants(matching: .button).matching(identifier: "copyButton"),
      newButton: popOver.descendants(matching: .button).matching(identifier: "newButton"),
      passphraseArea: popOver.descendants(matching: .other).matching(identifier: "passphraseArea")
    )

    return (popOver, popOverContents)
  }
}

struct PopOverContents {
  let quitButton: XCUIElementQuery
  let aboutButton: XCUIElementQuery
  let copyButton: XCUIElementQuery
  let newButton: XCUIElementQuery
  let passphraseArea: XCUIElementQuery
}

struct AboutWindowContents {
  let closeButton: XCUIElementQuery
  let text: XCUIElementQuery
}