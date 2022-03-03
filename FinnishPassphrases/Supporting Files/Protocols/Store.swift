//
//  Store.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 2.3.2022.
//

import Foundation

protocol Store {

  var numberOfWords: Int { get set }
  var separatorSymbol: SeparatorSymbol { get set }
  var mixedCase: Bool { get set }

}
