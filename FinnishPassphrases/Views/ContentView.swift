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

                CustomHoverButton(
                    icon: Image(systemName: "xmark.square.fill"),
                    labelText: LocalizedStringKey("quitButton"),
                    action: appState.quitApplication
                )

                CustomHoverButton(
                    icon: Image(systemName: "ellipsis.rectangle.fill"),
                    labelText: LocalizedStringKey("aboutButton"),
                    action: appState.displayAboutWindow
                )

                CustomHoverButton(
                    icon: Image(systemName: "doc.on.doc.fill"),
                    labelText: LocalizedStringKey("copyPassphraseButton"),
                    action: appState.copyPassphraseToPasteboard
                )
                    .keyboardShortcut(KeyboardShortcut("c", modifiers: .command))

                CustomHoverButton(
                    icon: Image(systemName: "wand.and.stars"),
                    labelText: LocalizedStringKey("generateNewPassphraseButton"),
                    action: appState.generateNewPassphrase
                )
                    .keyboardShortcut(KeyboardShortcut(.space, modifiers: []))
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
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
