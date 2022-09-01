//
//  FinnishPasswordsApp.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

@main
struct FinnishPasswordsApp: App {
  // Settings Scene is used here to be able to return no initial SwiftUI view to display
  // swiftlint:disable:next weak_delegate
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var body: some Scene {
    Settings { }
  }
}
