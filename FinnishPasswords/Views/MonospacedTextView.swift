//
//  WordView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 19.6.2021.
//

import SwiftUI

/// A view which displays monospaced text
struct MonospacedTextView: View {

    let stringToDisplay: String
    let spacing: CGFloat

    /// - Parameter word: The text that will be displayed
    /// - Parameter spacing: Defines the spacing between the characters. Default set to 5.
    init(stringToDisplay: String, spacing: CGFloat = 5) {
        self.stringToDisplay = stringToDisplay
        self.spacing = spacing
    }

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<stringToDisplay.count, id: \.self) { index in
                Text(String(stringToDisplay[stringToDisplay.index(stringToDisplay.startIndex, offsetBy: index)]))
                    .font(fPasswordFontMain)
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
