//
//  GeneratorView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 16.8.2021.
//

import SwiftUI

struct GeneratorView: View {

    @EnvironmentObject var appState: AppState

}

// MARK: - Views
extension GeneratorView {
    var body: some View {
        VStack(alignment: .center) {
            PassphraseDispalyerView(passphrase: $appState.passphrase)
                .environmentObject(appState)
                .padding(cGeneratorViewRowPadding)
            HStack(spacing: 2) {
                SeparatorFlicker(current: $appState.separator, availableSeparators: cPasswordSeparators)
                    .padding(cGeneratorViewColumnPadding)

                WordAmountFlicker(
                    allowedRange: cPassphraseNumberOfWordsRangeInt,
                    currentNumberOfWords: $appState.numOfWords
                )

                Checkbox(
                    checked: $appState.capitalization,
                    description: LocalizedStringKey("generatorViewCapitalizationCheckbox")
                )
                .padding(cGeneratorViewColumnPadding)
                Spacer()
            }
        }
    }
}

// MARK: - Preview
#if DEBUG
struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
            .environmentObject(AppState.previewShared)
            .frame(width: 400)
    }
}
#endif
