//
//  Character.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 20.6.2021.
//

import Foundation

extension Character {

    /// Flips the case of the character
    /// lower case -> upper case
    /// upper case -> lower case
    func flipCase() -> Character {
        if self.isUppercase {
            return Character(self.lowercased())
        }
        return Character(self.uppercased())
    }
}
