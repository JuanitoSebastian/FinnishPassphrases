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

// MARK: Views
extension GeneratorView {
    var body: some View {
        VStack(alignment: .center) {
            PassphraseDispalyerView(passphrase: $appState.passphrase)
                .environmentObject(appState)
                .padding(.vertical, 1)

            Divider()

            WordAmountSlider()
                .environmentObject(appState)
                .padding(.vertical, 1)

            Divider()

            SeparatorSelectorView()
                .environmentObject(appState)
                .padding(.vertical, 1)
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
