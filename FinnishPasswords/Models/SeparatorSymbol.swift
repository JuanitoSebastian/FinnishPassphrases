//
//  SeparatorSymbol.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

enum SeparatorSymbol: Int {

    case asterisk
    case hyphen
    case slash
    case hash

    var name: String {
        switch self {
        case .asterisk: return "Asterisk"
        case .hash: return "Hash"
        case .slash: return "Slash"
        case .hyphen: return "Hyphen"
        }
    }

    var symbol: Character {
        switch self {
        case .asterisk: return "*"
        case .hyphen: return "-"
        case .slash: return "/"
        case .hash: return "#"
        }
    }
}
