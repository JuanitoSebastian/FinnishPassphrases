//
//  Double.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 15.8.2021.
//

import Foundation

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
