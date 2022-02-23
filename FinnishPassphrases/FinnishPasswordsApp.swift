//
//  FinnishPasswordsApp.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

@main
struct FinnishPasswordsApp: App {
  // swiftlint:disable:next weak_delegate
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var body: some Scene {
    Settings { }
  }
}
