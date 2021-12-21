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
        VStack {
            VStack {
                HStack {
                    Text(LocalizedStringKey("contentViewTitle"))
                        .font(cUiTitleFont)
                        .foregroundColor(cTitleColor)
                    Spacer()
                    IconButton(icon: Image(systemName: "gearshape"), action: { appState.quitApplication() })
                        .environmentObject(appState)
                }

                GeneratorView()
                    .environmentObject(appState)
                    .background(
                        RoundedRectangle(cornerSize: cRoundedCornerSize)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(cBackdropColor)
                    )
            }
            .padding(cMainContentPadding)

            FooterView()
                .environmentObject(appState)
        }
        .background(cBackdropColor)
        .frame(width: 400)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState.previewShared)
    }
}
#endif
