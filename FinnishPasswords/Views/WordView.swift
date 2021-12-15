//
//  WordView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 19.6.2021.
//

import SwiftUI

/// A view which displays monospaced text
/// - Parameter word: The text that will be displayed
struct MonospacedTextView: View {

    let stringToDisplay: String

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<stringToDisplay.count, id: \.self) { index in
                Text(String(stringToDisplay[stringToDisplay.index(stringToDisplay.startIndex, offsetBy: index)]))
                    .font(fPasswordFontLarge)
                    .fixedSize(horizontal: true, vertical: false) // Fixes issues with geometry reader

            }
        }
    }
}

#if DEBUG
struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        MonospacedTextView(stringToDisplay: "saippuakauppias")
    }
}
#endif