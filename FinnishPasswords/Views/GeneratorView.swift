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
                    .padding(cGeneratorViewColumnPadding)

                Button {
                    appState.generatePassphrase()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(PlainButtonStyle())
                .padding(cGeneratorViewColumnPadding)
            }
            .padding(cGeneratorViewRowPadding)

            Divider()

            WordAmountSlider()
                .environmentObject(appState)
                .padding(cGeneratorViewRowPadding)

            Divider()

            HStack {
                SeparatorSelectorView()
                    .environmentObject(appState)
                    .padding(cGeneratorViewColumnPadding)

                Checkbox(
                    checked: $appState.capitalization,
                    description: LocalizedStringKey("generatorViewCapitalizationCheckbox")
                )
                .padding(cGeneratorViewColumnPadding)
            }
            .padding(cGeneratorViewRowPadding)

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
