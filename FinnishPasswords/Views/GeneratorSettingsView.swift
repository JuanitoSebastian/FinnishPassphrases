//
//  GeneratorSettingsView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct GeneratorSettingsView: View {

    @EnvironmentObject var appState: AppState
    @State var numOfWords: Int = DefaultsStore.shared.numberOfWordsInPassphrase

    var body: some View {
        HStack(spacing: 10) {

            Stepper(
                onIncrement: { incrementNumbOfWords() },
                onDecrement: { decrementNumOfWords() },
                label: { return Text("\(numOfWords)").font(fPasswordFontMedium) }
            )

            SeparatorSelectorView()

            Spacer()

            Menu {
                Button { appState.quitApplication() } label: {
                    Text("Quit application")
                }
            } label: {
                Text("⚙️")
            }
            .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: false))
            .frame(width: 50)
        }
    }
}

// MARK: - Functions
extension GeneratorSettingsView {

    func incrementNumbOfWords() {
        appState.incrementNumberOfWordsInPassphrase()
        numOfWords = DefaultsStore.shared.numberOfWordsInPassphrase
        appState.generatePassphrase()
    }

    func decrementNumOfWords() {
        appState.decrementNumberOfWordsInPassphrase()
        numOfWords = DefaultsStore.shared.numberOfWordsInPassphrase
        appState.generatePassphrase()
    }
}
