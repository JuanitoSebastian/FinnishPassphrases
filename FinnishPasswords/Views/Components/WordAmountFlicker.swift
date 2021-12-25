//
//  WordAmountFlicker.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 22.12.2021.
//

import SwiftUI

struct WordAmountFlicker: View {

    let allowedRange: ClosedRange<Int>
    @Binding var currentNumberOfWords: Int

    init(
        allowedRange: ClosedRange<Int>,
        currentNumberOfWords: Binding<Int>
    ) {
        self.allowedRange = allowedRange
        self._currentNumberOfWords = currentNumberOfWords
    }

    var body: some View {
        Button {
            increment()
        } label: {
            HStack(alignment: .center) {
                Text(String(currentNumberOfWords))
                    .foregroundColor(cPassphraseSeparatorColor)
                    .font(cSeparatorFlickerFontSeparator)

                Text("words")
                    .foregroundColor(cTitleColor)
                    .font(cSeparatorFlickerFontDescription)
            }
            .padding(cModifierButtonPadding)
            .frame(width: 100, height: 30)
            .background(
                RoundedRectangle(cornerSize: cRoundedCornerSize)
                    .foregroundColor(cFooterBackgroundColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Functions
extension WordAmountFlicker {
    private func increment() {
        guard allowedRange.contains(currentNumberOfWords + 1) else {
            currentNumberOfWords = allowedRange.lowerBound
            return
        }
        currentNumberOfWords += 1
    }
}

// MARK: - Preview
#if DEBUG
struct WordAmountFlicker_Previews: PreviewProvider {
    static var previews: some View {
        WordAmountFlicker(
            allowedRange: cPassphraseNumberOfWordsRangeInt,
            currentNumberOfWords: .constant(3)
        )
    }
}
#endif
