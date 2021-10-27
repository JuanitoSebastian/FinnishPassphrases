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

    var body: some View {
        HStack(spacing: 3) {

            Image(systemName: checked ? "checkmark.square.fill" : "square")


            Text(description)
                .font(fUiFontSmall)

        }
        .onTapGesture {
            checked.toggle()
        }
        .padding(1)

    }
}

#if DEBUG
struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(checked: .constant(true), description: "Kirjainkoko")
    }
}
#endif
