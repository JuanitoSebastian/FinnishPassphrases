//
//  WordAmountFlicker.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 14.1.2022.
//

import SwiftUI

struct WordAmountFlicker: View {

    @Binding var wordCount: Int
    private let numberRange: ClosedRange<Int>
    private let numberFont: Font
    private let numberColor: Color
    private let circleStrokeColor: Color
    private let circleSymbolColor: Color
    private let circleSymbolFont: Font

    init(
        numberRange: ClosedRange<Int> = cPassphraseNumberOfWordsRangeInt,
        wordCount: Binding<Int>
    ) {
        self.numberRange = numberRange
        self._wordCount = wordCount
        self.numberFont = Font.system(size: 20, design: .default)
        self.numberColor = Color("black")
        self.circleStrokeColor = Color("lighter-blue")
        self.circleSymbolColor = Color("medium-blue")
        self.circleSymbolFont = Font.system(size: 15, design: .rounded).weight(.bold)
    }

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
            .fill(Color.white)
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
                    .fill(Color.white)
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
        WordAmountFlicker(wordCount: .constant(3))
    }
}
#endif
