//
//  WordAmountSlider.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 16.8.2021.
//

import SwiftUI

struct WordAmountSlider: View {
    @EnvironmentObject var appState: AppState
    @State var numOfWords: Double = Double(DefaultsStore.shared.numberOfWordsInPassphrase)
}

// MARK: - Views
extension WordAmountSlider {
    var body: some View {
        Slider(value: $numOfWords,
               in: Double(cMinimumNumberOfWordsInPassphrase)...Double(cMaximumNumberOfWordsInPassphrase),
               step: 1,
               onEditingChanged: { editing in setNumberOfWords(editing: editing) },
               minimumValueLabel: Text(""),
               maximumValueLabel: Text(""),
               label: { wordAmountLabel })
    }

    var wordAmountLabel: some View {
        Text(LocalizedStringKey("generatorViewWordCount \(numOfWords.cleanValue)"))
            .font(cUiFontMedium)
    }
}

// MARK: - Functions
extension WordAmountSlider {
    func setNumberOfWords(editing: Bool) {
        guard !editing else { return }
        appState.setNumberOfWordsInPassphrase(Int(numOfWords))
        appState.generatePassphrase()
    }
}

// MARK: - Previews
#if DEBUG
struct WordAmountSlider_Previews: PreviewProvider {
    static var previews: some View {
        WordAmountSlider()
            .environmentObject(AppState())
    }
}
#endif
