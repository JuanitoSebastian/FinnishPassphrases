//
//  DefaultsStore.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import Foundation

/// A convenient wrapper for UserDefaults. The variables can be set and the change is saved automatically.
class DefaultsStore {

  private let userDefaults: UserDefaults

  /// - Parameter userDefaults: UserDefaults object to use. For testing you can use `UserDefaults(suiteName: #file)`
  init(userDefaults: UserDefaults = UserDefaults()) {
    self.userDefaults = userDefaults
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
