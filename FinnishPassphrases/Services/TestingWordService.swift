//
//  TestingWordService.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 2.3.2022.
//

import Foundation

class TestingWordService: WordService {

  let word: [String] = cTestingWords

  func randomWord() -> String {
    return word.randomElement()!
  }
}
