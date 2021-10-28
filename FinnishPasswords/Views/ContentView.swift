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
            HStack {
                Text(LocalizedStringKey("contentViewTitle"))
                    .font(cUiTitleFont)
                    .foregroundColor(cTitleColor)
                Spacer()
                IconButton(icon: Image(systemName: "multiply"), action: { appState.quitApplication() })
            }
            GeneratorView()
                .environmentObject(appState)
                .background(
                    RoundedRectangle(cornerSize: cRoundedCornerSize)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(cBackdropColor)
                )
        }
        .padding()
        .background(cBackdropColor)
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
