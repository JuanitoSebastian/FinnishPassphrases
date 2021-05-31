//
//  SeparatorSelectorView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import SwiftUI

struct SeparatorSelectorView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 10) {
            ForEach(fPasswordSeparators, id: \.self) { separator in
                Text(String(separator.symbol))
                    .font(fPasswordFontMedium)
            }
        }
    }
}

#if DEBUG
struct SeparatorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorSelectorView()
            .environmentObject(AppState())
    }
}
#endif
