//
//  SeparatorFlicker.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 21.12.2021.
//

import SwiftUI

struct SeparatorFlicker: View {

    @Binding var current: SeparatorSymbol
    let availableSeparators: [SeparatorSymbol]

    @State var midAnimation: Bool
    @State var currentSeparatorOffset: CGSize
    @State var nextSeparatorOffset: CGSize

    init(current: Binding<SeparatorSymbol>, availableSeparators: [SeparatorSymbol]) {
        self._current = current
        self.availableSeparators = availableSeparators
        self.midAnimation = false
        self.currentSeparatorOffset = CGSize(width: 0, height: 0)
        self.nextSeparatorOffset = CGSize(width: 0, height: 30)
    }

}

// MARK: - Views
extension SeparatorFlicker {

    var body: some View {
        Button {
            handleClick()
        } label: {
            ZStack {
                createSeparatorText(symbol: current.symbol, name: current.name)
                    .offset(currentSeparatorOffset)
                createSeparatorText(symbol: nextSeparator.symbol, name: nextSeparator.name)
                    .offset(nextSeparatorOffset)
            }
            .padding(cModifierButtonPadding)
            .frame(width: 100, height: 30)
            .background(
                createRectangle(color: cFooterBackgroundColor)
            )
            .mask(
                createRectangle(color: .white)
            )
        }
        .buttonStyle(PlainButtonStyle())

    }

    @ViewBuilder
    private func createSeparatorText(
        symbol: Character, name: String
    ) -> some View {
        AnyView(
            HStack(alignment: .center) {
                Text(String(symbol))
                    .foregroundColor(cPassphraseSeparatorColor)
                    .font(cSeparatorFlickerFontSeparator)

                Text(name)
                    .foregroundColor(cTitleColor)
                    .font(cSeparatorFlickerFontDescription)
            }
        )
    }

    @ViewBuilder
    private func createRectangle(color: Color) -> some View {
        RoundedRectangle(cornerSize: cRoundedCornerSize)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Supporting
extension SeparatorFlicker {

    private var currentIndex: Int {
        for (index, separator) in availableSeparators.enumerated()
        where current == separator {
            return index
        }
        return 0
    }

    private var nextSeparator: SeparatorSymbol {
        return currentIndex < (availableSeparators.count - 1) ?
            availableSeparators[currentIndex + 1] : availableSeparators[0]
    }

    private func handleClick() {
        guard !midAnimation else { return }
        midAnimation = true

        withAnimation(cFlickerButtonAnimation) {
            currentSeparatorOffset = CGSize(width: 0, height: -30)
            nextSeparatorOffset = CGSize(width: 0, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            current = nextSeparator
            currentSeparatorOffset = CGSize(width: 0, height: 0)
            nextSeparatorOffset = CGSize(width: 0, height: 30)
            midAnimation = false
        }
    }
}

// MARK: - Preview
#if DEBUG
struct SeparatorFlicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeparatorFlicker(
                current: .constant(SeparatorSymbol.asterisk),
                availableSeparators: cPasswordSeparators
            )
        }
    }
}
#endif
