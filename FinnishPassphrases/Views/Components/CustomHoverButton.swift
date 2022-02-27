//
//  CustomHoverButton.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 20.2.2022.
//

import SwiftUI

struct CustomHoverButton: View {

  let icon: Image
  let labelText: LocalizedStringKey
  let action: () -> Void
  let iconColor: Color = Color("button-symbol")
  let textColor = Color("button-text")
  let labelFont = Font.system(size: 14, design: .rounded).weight(.medium)
  let iconFont = Font.system(size: 12).weight(.medium)
  @State var hoveringState = false

  var body: some View {
    Button {
      withAnimation(.none) {
        action()
      }
    } label: {
      HStack(spacing: 6) {
        icon
          .font(iconFont)
          .foregroundColor(iconColor)

        Text(labelText)
          .foregroundColor(textColor)
          .font(labelFont)
      }
      .contentShape(Rectangle())
      .offset(y: hoveringState ? -2 : 0)
    }
    .buttonStyle(PlainButtonStyle())
    .onHover { hovering in
      // Could there be a delay so the box does not close immediately
      // when the user stops hovering?
      withAnimation(.easeInOut(duration: 0.2)) {
        hoveringState = hovering
      }
    }

  }

}

#if DEBUG
struct CustomHoverButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomHoverButton(
      icon: Image(systemName: "square.and.arrow.up"),
      labelText: LocalizedStringKey("generateNewPassphraseButton"),
      action: { }
    )
  }
}
#endif
