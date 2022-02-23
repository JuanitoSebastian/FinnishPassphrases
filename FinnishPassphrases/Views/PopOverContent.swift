//
//  ContentView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

/// Main content displayed in the pop over. AppState is passed to constructor.
/// AppState is passed on from here as an Environment Object.
struct PopOverContent: View {

  @ObservedObject var appState: AppState
  private let backgroundColor = Color("backdrop")
  private let padding = EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20)

}

// MARK: - Views
extension PopOverContent {
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

      HStack(spacing: 28) {
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
      .padding(padding)
    }
    .frame(width: 500, height: 250)
  }
}

// MARK: - Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PopOverContent(appState: AppState.previewShared)
  }
}
#endif
