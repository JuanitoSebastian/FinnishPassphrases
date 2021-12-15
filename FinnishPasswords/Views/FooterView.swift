//
//  FooterView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.10.2021.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(cFooterBackgroundColor)

            VStack(alignment: .center) {
                Text("Sovellus käyttää Kotuksen nykysuomen sanalistaa")
                    .font(cFooterFont)
                Text("App by juan.fi")
                    .font(cFooterFont)
            }

        }

    }
}

#if DEBUG
struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
#endif
