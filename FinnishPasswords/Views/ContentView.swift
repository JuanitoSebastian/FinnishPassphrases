//
//  ContentView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var appState: AppState = AppState()

    var body: some View {
        VStack {

            VStack(spacing: 2) {
                PassphraseDispalyerView(passphrase: $appState.passphrase)
                    .environmentObject(appState)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
            }
            .background(
                RoundedRectangle(cornerSize: fRoundedCornerSize)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(contentBackgroundColor)
            )

            GeneratorSettingsView()
                .environmentObject(appState)
        }
        .padding()
        .frame(width: 400)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
#endif
