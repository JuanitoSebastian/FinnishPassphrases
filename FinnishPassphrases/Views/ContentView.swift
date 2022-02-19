//
//  ContentView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var appState: AppState
    private let backgroundColor = Color("backdrop")

    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                SettingsPanel()
                    .environmentObject(appState)

                PassphraseDispalyerView(passphrase: $appState.passphrase)
                    .environmentObject(appState)
                    .onDrag { NSItemProvider(object: appState.passphrase.passphrase as NSString )}

                Spacer()
            }
            .background(backgroundColor)

            HStack(spacing: 10) {
                Spacer()
                IconButton(
                    icon: Image(systemName: "info"),
                    action: appState.displayAboutWindow
                )
                IconButton(
                    icon: Image(systemName: "square.and.arrow.up"),
                    action: appState.copyPassphraseToPasteboard
                )
                IconButton(
                    icon: Image(systemName: "arrow.counterclockwise"),
                    action: appState.generateNewPassphrase,
                    actionAnimated: true
                )
            }
            .padding(40)
        }
        .frame(width: 500, height: 250)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState.previewShared)
    }
}
#endif
