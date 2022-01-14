//
//  ContentView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        HStack {
            SettingsPanel()
                .environmentObject(appState)

            PassphraseDispalyerView(passphrase: $appState.passphrase)
                .environmentObject(appState)

            Spacer()
        }
        .background(Color.white)
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
