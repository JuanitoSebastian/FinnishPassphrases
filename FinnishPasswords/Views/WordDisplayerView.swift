//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct WordDisplayerView: View {

    @Binding var passphrase: Passphrase?

}

// MARK: - Views
extension WordDisplayerView {
    var body: some View {
        ZStack {
            content
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .animation(.spring())
        }
        .background(
            RoundedRectangle(cornerSize: fRoundedCornerSize)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(contentBackgroundColor)
        )
    }

    var content: AnyView {
        guard let passphrase = passphrase else {
            return noPassphraseGenerated
        }
        return AnyView(passphraseView(passphraseUnwrapped: passphrase))
    }

    var noPassphraseGenerated: AnyView {
        return AnyView(
            HStack(alignment: .center, spacing: 2) {
                Text("-")
                    .font(fPasswordFontLarge)
            }
        )
    }

    @ViewBuilder func passphraseView(passphraseUnwrapped: Passphrase) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 2) {
                ForEach(0..<passphraseUnwrapped.numOfWords, id: \.self) { index in
                    Text(passphraseUnwrapped.words[index])
                        .font(fPasswordFontLarge)
                    if index < (passphraseUnwrapped.numOfWords - 1) {
                        Text(String(passphraseUnwrapped.separator.symbol))
                            .font(fPasswordFontLarge)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
