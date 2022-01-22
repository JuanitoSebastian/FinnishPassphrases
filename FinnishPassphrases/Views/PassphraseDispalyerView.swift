//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI
import WrappingHStack

struct PassphraseDispalyerView: View {

    @Binding var passphrase: Passphrase
    @EnvironmentObject var appState: AppState

    private let passphraseTextPadding = EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    private let passphraseAreaPadding = EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)

    private let passphraseFont = Font.system(size: 18, design: .monospaced).weight(.regular)
    private let passphraseWordColor = Color("black")
    private let passphraseSeparatorColor = Color("blue")

}

// MARK: - Views
extension PassphraseDispalyerView {

    var body: some View {
        VStack(alignment: .leading) {
            WrappingHStack(
                0..<passphrase.numOfWords,
                id: \.self,
                alignment: .leading,
                spacing: .constant(1)
            ) {
                Text(passphrase.words[$0])
                    .font(passphraseFont)
                    .foregroundColor(passphraseWordColor)
                    .padding(passphraseTextPadding)
                    if $0 < (passphrase.numOfWords - 1) {
                        Text(String(passphrase.separator.symbol))
                            .font(passphraseFont)
                            .foregroundColor(passphraseSeparatorColor)
                            .padding(passphraseTextPadding)
                    }
            }
            .padding(passphraseAreaPadding)

            Spacer()

        }
        .onTapGesture {
            handleOnClick()
        }
    }

}

// MARK: - Functions
extension PassphraseDispalyerView {
    private func handleOnClick() {
        appState.copyPassphraseToPasteboard()
    }
}
