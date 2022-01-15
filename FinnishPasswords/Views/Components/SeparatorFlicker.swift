//
//  SeparatorFlicker.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 14.1.2022.
//

import SwiftUI

struct SeparatorFlicker: View {
    @Binding var currentSeparator: SeparatorSymbol
    @State private var index: Int
    private let separators: [SeparatorSymbol]
    private let numberFont: Font
    private let numberColor: Color
    private let circleStrokeColor: Color
    private let circleSymbolColor: Color
    private let circleSymbolFont: Font

    init(
        separators: [SeparatorSymbol],
        currentSeparator: Binding<SeparatorSymbol>
    ) {
        self.separators = separators
        self._currentSeparator = currentSeparator
        self.index = separators.firstIndex(of: currentSeparator.wrappedValue)!
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
                actionCircle(systemSymbolName: "chevron.left", action: { previous() })
                Spacer()
                actionCircle(systemSymbolName: "chevron.right", action: { next() })
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
        Text(String(currentSeparator.symbol))
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

// MARK: - Fucntions
extension SeparatorFlicker {
    private func next() {
        guard separators.indices.contains(index + 1) else {
            index = 0
            currentSeparator = separators[index]
            return
        }
        index += 1
        currentSeparator = separators[index]
    }

    private func previous() {
        guard separators.indices.contains(index - 1) else {
            index = separators.indices.last!
            currentSeparator = separators[index]
            return
        }
        index -= 1
        currentSeparator = separators[index]
    }
}

#if DEBUG
struct SeparatorFlicker_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorFlicker(separators: cPasswordSeparators, currentSeparator: .constant(.hash))
    }
}
#endif
