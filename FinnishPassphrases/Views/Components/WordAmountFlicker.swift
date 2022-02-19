//
//  WordAmountFlicker.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 14.1.2022.
//

import SwiftUI

/// A component for choosing a number within a range.
struct WordAmountFlicker: View {

    @Binding var wordCount: Int
    let numberRange: ClosedRange<Int>
    let numberFont: Font = Font.system(size: 20, design: .default)
    let numberColor: Color = Color("flicker-value-text")
    let flickerBackgroundColor: Color = Color("flicker-background")
    let circleStrokeColor: Color = Color("settings-panel-background")
    let circleSymbolColor: Color = Color("flicker-action-symbol")
    let circleSymbolFont: Font = Font.system(size: 15, design: .rounded).weight(.bold)

    var body: some View {
        ZStack(alignment: .center) {
            square

            number

            HStack {
                actionCircle(systemSymbolName: "minus", action: { decrement() })
                Spacer()
                actionCircle(systemSymbolName: "plus", action: { increment() })
            }
        }
        .frame(maxWidth: 76)
    }

    private var square: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(flickerBackgroundColor)
            .frame(width: 40, height: 40)
    }

    private var number: some View {
        Text(String(wordCount))
            .font(numberFont)
            .foregroundColor(numberColor)
    }

    @ViewBuilder
    private func actionCircle(systemSymbolName: String, action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(flickerBackgroundColor)
                    .frame(width: 23, height: 23)

                Circle()
                    .stroke(circleStrokeColor, lineWidth: 2)
                    .frame(width: 23, height: 23)

                Image(systemName: systemSymbolName)
                    .foregroundColor(circleSymbolColor)
                    .font(circleSymbolFont)

            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Functions
extension WordAmountFlicker {
    private func increment() {
        guard numberRange.contains(wordCount + 1) else { return }
        wordCount += 1
    }

    private func decrement() {
        guard numberRange.contains(wordCount - 1) else { return }
        wordCount -= 1
    }
}

// MARK: - Preview
#if DEBUG
struct WordAmountFlicker_Previews: PreviewProvider {
    static var previews: some View {
        WordAmountFlicker(wordCount: .constant(3), numberRange: cPassphraseNumberOfWordsRangeInt)
    }
}
#endif
