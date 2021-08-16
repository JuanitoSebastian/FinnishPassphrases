//
//  GeneratorSettingsView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct GeneratorSettingsView: View {

    @EnvironmentObject var appState: AppState
    @State var numOfWords: Double = Double(DefaultsStore.shared.numberOfWordsInPassphrase)
}

// MARK: - Views
extension GeneratorSettingsView {
    var body: some View {
        VStack {

            Divider()

            HStack(spacing: 10) {
                Spacer()
                WordAmountSlider()
                    .environmentObject(appState)
                Spacer()
            }

            Divider()

            HStack(spacing: 10) {
                Spacer()

                SeparatorSelectorView()

                Spacer()

//                Menu {
//                    Button { appState.quitApplication() } label: {
//                        Text("Quit application")
//                    }
//                } label: {
//                    Text("⚙️")
//                }
//                .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: false))
//                .frame(width: 50)
            }

        }
    }
}

// MARK: - Functions
extension GeneratorSettingsView {

}
