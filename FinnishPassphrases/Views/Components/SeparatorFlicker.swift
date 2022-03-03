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
  private let circleBackgroundColor: Color
  private let circleSymbolFont: Font
  private let flickerBackgroundColor: Color

  init(
    separators: [SeparatorSymbol],
    currentSeparator: Binding<SeparatorSymbol>
  ) {
    self.separators = separators
    self._currentSeparator = currentSeparator
    self.index = separators.firstIndex(of: currentSeparator.wrappedValue)!
    self.numberFont = Font.system(size: 20, design: .default)
    self.flickerBackgroundColor = Color("flicker-background")
    self.numberColor = Color("flicker-value-text")
    self.circleBackgroundColor = Color("flicker-background")
    self.circleStrokeColor = Color("settings-panel-background")
    self.circleSymbolColor = Color("flicker-action-symbol")
    self.circleSymbolFont = Font.system(size: 15, design: .rounded).weight(.bold)
  }

  var body: some View {
    ZStack(alignment: .center) {
      square

      separator
        .accessibilityIdentifier("currentSeparator")
        .accessibilityLabel(LocalizedStringKey("currentSeparatorAccessibility \(currentSeparator.name)"))

      HStack {
        actionCircle(systemSymbolName: "chevron.left", action: { previous() })
          .accessibilityIdentifier("previousSeparatorButton")
          .accessibilityLabel(LocalizedStringKey("previousSeparatorButtonAccessibility"))
        Spacer()
        actionCircle(systemSymbolName: "chevron.right", action: { next() })
          .accessibilityIdentifier("nextSeparatorButton")
          .accessibilityLabel(LocalizedStringKey("nextSeparatorButtonAccessibility"))
      }
    }
    .frame(maxWidth: 76)
  }

  private var square: some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(flickerBackgroundColor)
      .frame(width: 40, height: 40)
  }

  private var separator: some View {
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
          .fill(circleBackgroundColor)
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
