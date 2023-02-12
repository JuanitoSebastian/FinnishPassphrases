//
//  TestsHelper.swift
//  Finnish PassphrasesEndToEndTests
//
//  Created by Juan Covarrubias on 3.3.2022.
//

import Foundation
import XCTest

func getAboutWindow(app: XCUIApplication) -> (XCUIElementQuery, AboutWindowContents) {
  let aboutWindow = app.descendants(matching: .any).matching(identifier: "aboutWindow")
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
    quitButton: app.buttons["quitButton"],
    aboutButton: app.buttons["aboutButton"],
    copyButton: app.buttons["copyButton"],
    newButton: app.buttons["newButton"],
    passphraseArea: app.otherElements["passphraseArea"],
    decrementNumebrOfWordsButton: app.buttons["decrementNumberOfWordsButton"],
    incrementNumbberOfWordsButton: app.buttons["incrementNumberOfWordsButton"],
    numberOfWords: app.staticTexts["currentNumberOfWords"],
    previousSeparatorButton: app.buttons["previousSeparatorButton"],
    nextSeparatorButton: app.buttons["nextSeparatorButton"],
    currentSeparator: app.staticTexts["currentSeparator"],
    mixedCaseToggle: app.checkBoxes["mixedCaseToggle"]
  )

  return (popOver, popOverContents)
}

func getPassphraseFromElement(_ passphraseArea: XCUIElement) -> String {
  let labelString = passphraseArea.label
  return String(labelString.suffix(labelString.count - 22))
}

struct PopOverContents {
  let quitButton: XCUIElement
  let aboutButton: XCUIElement
  let copyButton: XCUIElement
  let newButton: XCUIElement
  let passphraseArea: XCUIElement

  let decrementNumebrOfWordsButton: XCUIElement
  let incrementNumbberOfWordsButton: XCUIElement
  let numberOfWords: XCUIElement

  let previousSeparatorButton: XCUIElement
  let nextSeparatorButton: XCUIElement
  let currentSeparator: XCUIElement

  let mixedCaseToggle: XCUIElement
}

struct AboutWindowContents {
  let closeButton: XCUIElementQuery
  let text: XCUIElementQuery
}
