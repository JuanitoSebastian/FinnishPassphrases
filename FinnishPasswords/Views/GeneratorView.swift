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
            HStack {
                PassphraseDispalyerView(passphrase: $appState.passphrase)
                    .environmentObject(appState)
                    .padding(fGeneratorViewColumnPadding)

                Button {
                    appState.generatePassphrase()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(PlainButtonStyle())
                .padding(fGeneratorViewColumnPadding)
            }
            .padding(fGeneratorViewRowPadding)

            Divider()

            WordAmountSlider()
                .environmentObject(appState)
                .padding(fGeneratorViewRowPadding)

            Divider()

            HStack {
                SeparatorSelectorView()
                    .environmentObject(appState)
                    .padding(fGeneratorViewColumnPadding)

                Checkbox(
                    checked: $appState.capitalization,
                    description: LocalizedStringKey("generatorViewCapitalizationCheckbox")
                )
                .padding(fGeneratorViewColumnPadding)
            }
            .padding(fGeneratorViewRowPadding)

        }
    }
}

// MARK: - Preview
#if DEBUG
struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
            .environmentObject(AppState())
            .frame(width: 400)
    }
}
#endif
