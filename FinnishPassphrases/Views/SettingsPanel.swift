//
//  SettingsPanel.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 14.1.2022.
//

import SwiftUI

struct SettingsPanel: View {

    @EnvironmentObject var appState: AppState
    private let panelColor = Color("lighter-blue")
    private let panelPadding = EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
    private let labelFont = Font.system(size: 14, design: .default)
    private let labelColor = Color("gray")

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack(spacing: 6) {
                WordAmountFlicker(wordCount: $appState.numOfWords)
                Text(LocalizedStringKey("wordAmountLabel"))
                    .font(labelFont)
                    .foregroundColor(labelColor)
            }
            VStack(spacing: 6) {
                SeparatorFlicker(separators: cPasswordSeparators, currentSeparator: $appState.separator)
                Text(LocalizedStringKey("separatorLabel"))
                    .font(labelFont)
                    .foregroundColor(labelColor)
            }
            VStack(spacing: 6) {
                Toggle("", isOn: $appState.capitalization)
                    .toggleStyle(CustomToggleStyle())
                Text(LocalizedStringKey("capitalizationLabel"))
                    .font(labelFont)
                    .foregroundColor(labelColor)
            }
            Spacer()
        }
        .padding(panelPadding)
        .frame(width: 110)
        .background(panelColor)
    }
}

#if DEBUG
struct SettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPanel()
    }
}
#endif