//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct PassphraseDispalyerView: View {
    /// Variables
    @Binding var passphrase: Passphrase?
    @EnvironmentObject var appState: AppState
}

// MARK: - Views
extension PassphraseDispalyerView {

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack {
                passprhaseAreaContent
                    .animation(.spring())
                    .contentShape(Rectangle())
            }
        }
        .coordinateSpace(name: "scroll")
    }

    /// Determines what content to display.
    /// generatePassphraseView is only called if passphrase != nil
    var passprhaseAreaContent: AnyView {
        guard let passphrase = passphrase else {
            return AnyView(
                HStack(alignment: .center, spacing: 2) {
                    Text("-")
                        .font(fPasswordFontLarge)
                }
            )
        }
        return AnyView(generatePassphraseView(passphraseUnwrapped: passphrase))
    }

    /// Generates the passphrase texts and displayes them in a ScrollView
    @ViewBuilder
    func generatePassphraseView(passphraseUnwrapped: Passphrase) -> some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0..<passphraseUnwrapped.words.count, id: \.self) { index in
                MonospacedTextView(stringToDisplay: passphraseUnwrapped.words[index])
                if index < (passphraseUnwrapped.numOfWords - 1) {
                    Text(String(passphraseUnwrapped.separator.symbol))
                        .font(fPasswordFontLarge)
                        .foregroundColor(.blue)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
    }
}
