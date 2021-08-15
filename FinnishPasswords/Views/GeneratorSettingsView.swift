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
            HStack(spacing: 10) {
                Spacer()
                Slider(value: $numOfWords,
                       in: Double(fMinimumNumberOfWordsInPassphrase)...Double(fMaximumNumberOfWordsInPassphrase),
                       step: 1,
                       onEditingChanged: { editing in setNumberOfWords(editing: editing) },
                       minimumValueLabel: Text(""),
                       maximumValueLabel: Text(""),
                       label: { Text("\(numOfWords.cleanValue) sanaa") })
                Spacer()
            }

            HStack(spacing: 10) {
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
}

// MARK: - Functions
extension GeneratorSettingsView {

    func setNumberOfWords(editing: Bool) {
        guard !editing else { return }
        appState.setNumberOfWordsInPassphrase(Int(numOfWords))
        appState.generatePassphrase()
    }
}
