//
//  String.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 4.6.2021.
//

import Foundation

extension String {

    /// Converts a lowercase string to an uppercase string and an uppercase string to a lowercase string
    func flipCase() -> String {
        if Array(self)[0].isUppercase {
            return self.lowercased()
        }
        return self.uppercased()
    }
}
