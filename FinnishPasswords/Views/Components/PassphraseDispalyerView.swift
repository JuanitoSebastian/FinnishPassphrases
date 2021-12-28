//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI

struct PassphraseDispalyerView: View {

    @Binding var passphrase: Passphrase
    @EnvironmentObject var appState: AppState

    @State var textScale: CGSize = CGSize(width: 1, height: 1)
    @State var rectangleScale: CGSize = CGSize(width: 1, height: 1)

    @State var borderColor: Color = cPpassphraseBorderColor
    @State var backgroundColor: Color = cPassphraseBackgroundColor

}

// MARK: - Views
extension PassphraseDispalyerView {

    var body: some View {
        ZStack(alignment: .trailing) {
            ScrollView(.horizontal, showsIndicators: false) {
                passprhaseAreaContent
                    .contentShape(Rectangle())
                    .scaleEffect(textScale)
            }
            .scaleEffect(rectangleScale)
            .onHover(perform: { hovering in handleOnHover(hovering: hovering) })
            .onTapGesture { handleOnClick() }

            gradientFade
                .allowsHitTesting(false) // Enables interaction with the ScrollView underneath

            IconButton(icon: Image(systemName: "arrow.counterclockwise"), action: { appState.generateNewPassphrase() })
        }
        .padding(cPassphraseAreaPadding)
        .background(passphraseBackground)
        .overlay(passphraseOverlay)
        .scaleEffect(rectangleScale)
        .frame(maxHeight: 50)
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

    // Gradient fade
    var gradientFade: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [backgroundColor.opacity(0), backgroundColor]),
            startPoint: .init(x: 0.87, y: 0.5),
            endPoint: .init(x: 0.92, y: 0.5)
        )
    }

    /// Determines what content to display.
    /// generatePassphraseView is only called if passphrase != nil
    var passprhaseAreaContent: AnyView {
        return AnyView(generatePassphraseView(passphraseUnwrapped: passphrase))
    }

    /// Generates the passphrase texts
    @ViewBuilder
    func generatePassphraseView(passphraseUnwrapped: Passphrase) -> some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0..<passphraseUnwrapped.words.count, id: \.self) { index in
            Text(passphraseUnwrapped.words[index])
                    .font(cPasswordFontMain)
                if index < (passphraseUnwrapped.numOfWords - 1) {
                    Text(String(passphraseUnwrapped.separator.symbol))
                        .font(cPasswordFontMain)
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
        appState.copyPassphraseToPasteboard()
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
        withAnimation(cHoverAnimation) {
            if hovering {
                borderColor = cPassphraseBorderColorHover
                return
            }
            borderColor = cPpassphraseBorderColor
        }
    }
}
