//
//  SettingsPanel.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 14.1.2022.
//

import SwiftUI

/// A view that contains all of the elements for settings the users passphrase preferences
struct SettingsPanel: View {

  @EnvironmentObject var appState: AppState
  private let panelColor = Color("settings-panel-background")
  private let panelPadding = EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
  private let labelFont = Font.system(size: 14, design: .default)
  private let labelColor = Color("settings-panel-label-text")

  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      VStack(spacing: 6) {
        WordAmountFlicker(wordCount: $appState.numOfWords, numberRange: cPassphraseNumberOfWordsRangeInt)
        Text(LocalizedStringKey("wordAmountLabel"))
          .font(labelFont)
          .foregroundColor(labelColor)
          .accessibilityHidden(true)
      }

      VStack(spacing: 6) {
        SeparatorFlicker(separators: SeparatorSymbol.allCases, currentSeparator: $appState.separator)
        Text(LocalizedStringKey("separatorLabel"))
          .font(labelFont)
          .foregroundColor(labelColor)
          .accessibilityHidden(true)
      }

      VStack(spacing: 10) {
        Toggle("", isOn: $appState.capitalization)
          .toggleStyle(CustomToggleStyle())
          .accessibilityIdentifier("mixedCaseToggle")
          .accessibilityLabel(LocalizedStringKey("mixedCaseToggleAccessibility"))
        Text(LocalizedStringKey("capitalizationLabel"))
          .font(labelFont)
          .foregroundColor(labelColor)
          .accessibilityHidden(true)
      }
        .padding(.top, 4)
    }
    .padding(panelPadding)
    .frame(maxWidth: 110, maxHeight: .infinity)
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
