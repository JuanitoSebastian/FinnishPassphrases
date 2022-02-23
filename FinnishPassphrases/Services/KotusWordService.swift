//
//  KotusWordService.swift
//  FinnishPasswordGenerator
//
//  Created by Juan Covarrubias on 18.5.2021.
//

import Foundation

class KotusWordService {

  var xml: [String] = []
  private let startLine: Int
  private let nameOfXmlFile: String
  private let customData: String?

  init(nameOfXmlFile: String = "kotus-sanalista_v1", customData: String? = nil) {
    self.nameOfXmlFile = nameOfXmlFile
    self.customData = customData
    self.startLine = customData == nil ? 13 : 0
  }

  func readFileToMemory() {
    do {
      if let customData = customData {
        self.xml = customData.components(separatedBy: .newlines)
      } else {
        let data = try String(contentsOf: kotusWordsUrl, encoding: .utf8)
        self.xml = data.components(separatedBy: .newlines)
      }
    } catch {
      Log.e("Failed to read words from file")
    }
  }

  func randomWord() -> String {
    var word = trimXml(xml[Int.random(in: startLine..<xml.count)])
    // Making sure no special characters are included in the string (compound words)
    while true {
      if word.range(of: "^[a-zA-Z0-9äöüÄÖÜ]*$", options: .regularExpression) != nil { break }
      word = trimXml(xml[Int.random(in: startLine..<xml.count)])
    }
    return word
  }

  private func trimXml(_ string: String) -> String {
    var word = string
    word.removeFirst(7)

    var lastIndex = word.count
    if let range: Range<String.Index> = word.range(of: "</s>") {
      let index: Int = word.distance(from: word.startIndex, to: range.lowerBound)
      lastIndex = index
    }

    word.removeLast(word.count - lastIndex)
    return word
  }
}

extension KotusWordService {
  var kotusWordsUrl: URL {
    guard let urlToKotusWords = Bundle.main.url(forResource: nameOfXmlFile, withExtension: "xml") else {
      fatalError("Unable to access word list")
    }
    return urlToKotusWords
  }
}
