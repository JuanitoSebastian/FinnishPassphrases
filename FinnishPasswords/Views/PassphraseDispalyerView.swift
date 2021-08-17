//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct PassphraseDispalyerView: View {

    @Binding var passphrase: Passphrase?
    @EnvironmentObject var appState: AppState
}

// MARK: - Views
extension PassphraseDispalyerView {

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                passprhaseAreaContent
                    .animation(.spring())
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appState.copyToPasteboard()
                    }
            }
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

    }

    /// Determines what content to display.
    /// generatePassphraseView is only called if passphrase != nil
    var passprhaseAreaContent: AnyView {
        guard let passphrase = passphrase else {
            return AnyView(
                HStack(alignment: .center, spacing: 2) {
                    Text("-")
                        .font(fPasswordFontMain)
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
                Text(passphraseUnwrapped.words[index])
                    .font(fPasswordFontMain)
                    .fontWeight(.medium)
                if index < (passphraseUnwrapped.numOfWords - 1) {
                    Text(String(passphraseUnwrapped.separator.symbol))
                        .font(fPasswordFontMain)
                        .fontWeight(.medium)
                        .foregroundColor(passphraseSeparatorColor)
                        .padding(.horizontal, 2)
                }
            }
        }
    }
}
