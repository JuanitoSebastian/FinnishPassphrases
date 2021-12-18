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

}

// MARK: - Views
extension Checkbox {
    var body: some View {
        HStack(spacing: 3) {

            ZStack(alignment: .center) {
                RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                    .stroke(cCheckboxBorderColor, lineWidth: 2)

                RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                    .fill(checkboxFill)

                if checked {
                    Image(systemName: "checkmark")
                        .font((.system(size: 12, weight: .bold)))
                        .foregroundColor(.purple)
                }
            }
            .frame(width: 16, height: 16)
            .padding(.trailing, 2)

            Text(description)
                .font(cUiFontSmall)

        }
        .onTapGesture {
            checked.toggle()
        }
    }

    var checkboxFill: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [cCheckboxTopColor, cCheckboxBottomColor]),
            startPoint: checked ? .top : .bottom,
            endPoint: checked ? .bottom: .top
        )
    }
}

// MARK: - Preview
#if DEBUG
struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(checked: .constant(true), description: "Kirjainkoko")
    }
}
#endif
