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
    @State var hover: Bool = false
    @State var textScale: CGSize = CGSize(width: 1, height: 1)
    @State var rectangleScale: CGSize = CGSize(width: 1, height: 1)
    @State var backgroundColor: Color = passphraseBackgroundColor
}

// MARK: - Views
extension PassphraseDispalyerView {

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                passprhaseAreaContent
                    .contentShape(Rectangle())
                    .scaleEffect(textScale)
            }
            .padding(fPassphraseAreaPadding)
            .overlay(
                RoundedRectangle(cornerSize: fRoundedCornerSize)
                    .stroke(backgroundColor, lineWidth: 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            )
            .scaleEffect(rectangleScale)
            .onHover(perform: { hovering in
                withAnimation(fPassphraseAreaHoverAnimation) {
                    if hovering {
                        backgroundColor = passphraseBackgroundColorHover
                        return
                    }
                    backgroundColor = passphraseBackgroundColor
                }
            })
            .onTapGesture {
                appState.copyToPasteboard()
                onClickAnimation()
            }
            .scaleEffect(rectangleScale)
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

// MARK: - Functions
extension PassphraseDispalyerView {
    private func onClickAnimation() {
        withAnimation(fPassphraseAreaClickAnimation) {
            backgroundColor = passphraseBackgroundColorClick
            textScale = CGSize(width: 1.05, height: 1.025)
            rectangleScale = CGSize(width: 1.01, height: 1.01)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(fPassphraseAreaClickAnimation) {
                backgroundColor = passphraseBackgroundColor
                textScale = CGSize(width: 1.0, height: 1.0)
                rectangleScale = CGSize(width: 1.0, height: 1.0)
            }
        }
    }
}
