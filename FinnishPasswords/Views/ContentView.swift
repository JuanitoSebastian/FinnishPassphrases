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
        ZStack {
            GeneratorView()
                .environmentObject(appState)
                .background(
                    RoundedRectangle(cornerSize: fRoundedCornerSize)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(backdropColor)
                )
        }
        .padding()
        .background(Color.white)
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
