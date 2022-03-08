//
//  SeparatorSymbol.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

/// A symbol that separates words in a passphrase
enum SeparatorSymbol: Int, CaseIterable, Identifiable {

  case hyphen
  case asterisk
  case slash
  case hash

  /// English name of separator
  var name: String {
    switch self {
    case .asterisk: return "Asterisk"
    case .hash: return "Hash"
    case .slash: return "Slash"
    case .hyphen: return "Hyphen"
    }
  }

  /// Returns the separator as a character
  var symbol: Character {
    switch self {
    case .asterisk: return "*"
    case .hyphen: return "-"
    case .slash: return "/"
    case .hash: return "#"
    }
  }

  var id: Int {
    self.rawValue
  }
}
