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

    @State var textScale: CGSize = CGSize(width: 1, height: 1)
    @State var rectangleScale: CGSize = CGSize(width: 1, height: 1)

    @State var borderColor: Color = cPpassphraseBorderColor
    @State var backgroundColor: Color = cPassphraseBackgroundColor

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
            .padding(cPassphraseAreaPadding)
            .background(passphraseBackground)
            .overlay(passphraseOverlay)
            .scaleEffect(rectangleScale)
            .onHover(perform: { hovering in
                handleOnHover(hovering: hovering)
            })
            .onTapGesture { handleOnClick() }
            .scaleEffect(rectangleScale)
        }

    }

    // Background color
    var passphraseBackground: AnyView {
        return AnyView(
            RoundedRectangle(cornerSize: cRoundedCornerSize)
                .foregroundColor(backgroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }

    // Border
    var passphraseOverlay: AnyView {
        AnyView(
            RoundedRectangle(cornerSize: cRoundedCornerSize)
                .stroke(borderColor, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }

    /// Determines what content to display.
    /// generatePassphraseView is only called if passphrase != nil
    var passprhaseAreaContent: AnyView {
        guard let passphrase = passphrase else {
            return AnyView(
                HStack(alignment: .center, spacing: 2) {
                    Text("-")
                        .font(cPasswordFontMain)
                }
            )
        }
        return AnyView(generatePassphraseView(passphraseUnwrapped: passphrase))
    }

    /// Generates the passphrase texts
    @ViewBuilder
    func generatePassphraseView(passphraseUnwrapped: Passphrase) -> some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0..<passphraseUnwrapped.words.count, id: \.self) { index in
                Text(passphraseUnwrapped.words[index])
                    .font(cPasswordFontMain)
                    .fontWeight(.medium)
                if index < (passphraseUnwrapped.numOfWords - 1) {
                    Text(String(passphraseUnwrapped.separator.symbol))
                        .font(cPasswordFontMain)
                        .fontWeight(.medium)
                        .foregroundColor(cPassphraseSeparatorColor)
                        .padding(.horizontal, 2)
                }
            }
        }
    }
}

// MARK: - Functions
extension PassphraseDispalyerView {
    private func handleOnClick() {
        appState.copyToPasteboard()
        onClickAnimation()
    }

    private func onClickAnimation() {
        withAnimation(cPassphraseAreaClickAnimation) {
            borderColor = cPassphraseBorderColorClick
            textScale = CGSize(width: 1.05, height: 1.025)
            rectangleScale = CGSize(width: 1.01, height: 1.01)
            backgroundColor = cPassphraseBackgroundColorHover
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(cPassphraseAreaClickAnimation) {
                borderColor = cPpassphraseBorderColor
                textScale = CGSize(width: 1.0, height: 1.0)
                rectangleScale = CGSize(width: 1.0, height: 1.0)
                backgroundColor = cPassphraseBackgroundColor
            }
        }
    }

    private func handleOnHover(hovering: Bool) {
        withAnimation(cPassphraseAreaHoverAnimation) {
            if hovering {
                borderColor = cPassphraseBorderColorHover
                return
            }
            borderColor = cPpassphraseBorderColor
        }
    }
}
