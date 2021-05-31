//
//  ContentView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            WordDisplayerView(passphrase: $appState.passphrase)
            .onTapGesture {
                appState.copyToPasteboard()
            }
            GeneratorSettingsView()
            Button {
                appState.generatePassphrase()

            } label: {
                Text("Go!")
            }
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
