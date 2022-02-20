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
    let iconFont = Font.system(size: 14).weight(.medium)
    @State var hover = false

    var body: some View {
        RoundedSquareWrapper {
            Button {
                withAnimation(.none) {
                    action()
                }
            } label: {
                HStack(spacing: 6) {
                    icon
                        .foregroundColor(iconColor)
                        .font(iconFont)

                    if hover {
                        Text(labelText)
                            .foregroundColor(textColor)
                            .font(labelFont)
                    }
                }
            }
            .frame(height: 16)
            .buttonStyle(PlainButtonStyle())
        }
        .onHover { hovering in
            withAnimation {
                hover = hovering
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
