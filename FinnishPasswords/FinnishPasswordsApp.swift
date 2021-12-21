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
    @ObservedObject var appState: AppState

    init() {
        let kotusWordService = KotusWordService()
        kotusWordService.readFileToMemory()
        self.appState = AppState(
            passphraseGeneratorService: PassphraseGeneratorService(
                kotusWordService: kotusWordService
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState)
        }
    }
}
