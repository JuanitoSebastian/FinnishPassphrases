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
  @State var hoveringState = false

  var body: some View {
    Button {
      withAnimation(.none) {
        action()
      }
    } label: {
      Label { Text(labelText) } icon: { icon }
      .labelStyle(CustomLabelStyle())
      .offset(y: hoveringState ? -2 : 0)
    }
    .buttonStyle(PlainButtonStyle())
    .onHover { hovering in
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
