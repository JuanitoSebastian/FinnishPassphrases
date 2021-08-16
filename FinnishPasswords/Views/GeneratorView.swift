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
        VStack {
            HStack {
                PassphraseDispalyerView(passphrase: $appState.passphrase)
                    .environmentObject(appState)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerSize: fRoundedCornerSize)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(passphraseBackgroundColor)
                    )

                Button {
                    appState.generatePassphrase()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(PlainButtonStyle())
            }


            GeneratorSettingsView()
                .environmentObject(appState)
        }
    }
}

// MARK: - Preview
#if DEBUG
struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
            .environmentObject(AppState())
    }
}
#endif
