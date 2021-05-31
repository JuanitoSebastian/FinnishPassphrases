//
//  FinnishPasswordsApp.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

@main
struct FinnishPasswordsApp: App {

    let appState: AppState

    init() {
        self.appState = AppState()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
