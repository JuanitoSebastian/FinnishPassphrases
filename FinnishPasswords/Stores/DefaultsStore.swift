//
//  DefaultsStore.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

class DefaultsStore {

    private let userDefaults: UserDefaults

    init(userDetaults: UserDefaults = UserDefaults()) {
        self.userDefaults = userDetaults
    }

    var numberOfWordsInPassphrase: Int {
        get {
            let fetch = userDefaults.integer(forKey: "numberOfWordsInPassphras")
            return fetch != 0 ? fetch : 4
        }
        set(newValue) {
            userDefaults.setValue(newValue, forKey: "numberOfWordsInPassphras")
        }
    }

    var separatorSymbol: SeparatorSymbol {
        get {
            return SeparatorSymbol(rawValue: userDefaults.integer(forKey: "separatorSymbol")) ?? .hyphen
        }
        set(newValue) {
            userDefaults.set(newValue.rawValue, forKey: "separatorSymbol")
        }
    }

    var wordCapitalization: Bool {
        get {
            return userDefaults.bool(forKey: "wordCapitalization")
        }
        set(newValue) {
            userDefaults.setValue(newValue, forKey: "wordCapitalization")
        }
    }
}
