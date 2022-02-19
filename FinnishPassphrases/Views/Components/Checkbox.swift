//
//  Checkbox.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 18.8.2021.
//

import SwiftUI

struct Checkbox: View {

    @Binding var checked: Bool
    let description: LocalizedStringKey
    let checkmarkColor = Color("passphrase-separator")
    let textColor = Color("about-text-body")
    let textFont = Font.system(size: 14, design: .default).weight(.regular)

}

// MARK: - Views
extension Checkbox {
    var body: some View {
        HStack(spacing: 8) {

            ZStack(alignment: .center) {
                RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                    .fill(Color.white)

                if checked {
                    Image(systemName: "checkmark")
                        .font((.system(size: 18, weight: .bold)))
                        .foregroundColor(checkmarkColor)
                }
            }
            .frame(width: 22, height: 22)
            .padding(.trailing, 2)

            Text(description)
                .font(textFont)
                .foregroundColor(textColor)

        }
        .onTapGesture {
            checked.toggle()
        }
    }
}

// MARK: - Preview
#if DEBUG
struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(checked: .constant(true), description: "Don't show this again")
    }
}
#endif
