//
//  Checkbox.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 18.8.2021.
//

import SwiftUI

struct Checkbox: View {

    @Binding var checked: Bool
    var description: String?

    var body: some View {
        HStack(spacing: 3) {

            Image(systemName: checked ? "checkmark.square.fill" : "square")

            if description != nil {
                Text(description!)
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }

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
