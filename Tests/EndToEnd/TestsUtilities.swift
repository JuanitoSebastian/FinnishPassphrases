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
    quitButton: popOver.descendants(matching: .button).matching(identifier: "quitButton"),
    aboutButton: popOver.descendants(matching: .button).matching(identifier: "aboutButton"),
    copyButton: popOver.descendants(matching: .button).matching(identifier: "copyButton"),
    newButton: popOver.descendants(matching: .button).matching(identifier: "newButton"),
    passphraseArea: popOver.descendants(matching: .other).matching(identifier: "passphraseArea"),
    decrementNumebrOfWordsButton: popOver.descendants(matching: .button).matching(
      identifier: "decrementNumberOfWordsButton"
    ),
    incrementNumbberOfWordsButton: popOver.descendants(matching: .button).matching(
      identifier: "incrementNumberOfWordsButton"
    ),
    numberOfWords: popOver.descendants(matching: .staticText).matching(identifier: "currentNumberOfWords"),
    previousSeparatorButton: popOver.descendants(matching: .button).matching(identifier: "previousSeparatorButton"),
    nextSeparatorButton: popOver.descendants(matching: .button).matching(identifier: "nextSeparatorButton"),
    currentSeparator: popOver.descendants(matching: .staticText).matching(identifier: "currentSeparator"),
    mixedCaseToggle: popOver.descendants(matching: .checkBox).matching(identifier: "mixedCaseToggle")
  )

  return (popOver, popOverContents)
}

func getPassphraseFromElement(_ passphraseArea: XCUIElementQuery) -> String {
  let labelString = passphraseArea.element.label
  return String(labelString.suffix(labelString.count - 22))
}

struct PopOverContents {
  let quitButton: XCUIElementQuery
  let aboutButton: XCUIElementQuery
  let copyButton: XCUIElementQuery
  let newButton: XCUIElementQuery
  let passphraseArea: XCUIElementQuery

  let decrementNumebrOfWordsButton: XCUIElementQuery
  let incrementNumbberOfWordsButton: XCUIElementQuery
  let numberOfWords: XCUIElementQuery

  let previousSeparatorButton: XCUIElementQuery
  let nextSeparatorButton: XCUIElementQuery
  let currentSeparator: XCUIElementQuery

  let mixedCaseToggle: XCUIElementQuery
}

struct AboutWindowContents {
  let closeButton: XCUIElementQuery
  let text: XCUIElementQuery
}
