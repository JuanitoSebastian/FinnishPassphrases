//
//  SeparatorSelectorView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.5.2021.
//

import SwiftUI

struct SeparatorSelectorView: View {

    @EnvironmentObject var appState: AppState
    @State var currentSeparator: SeparatorSymbol = DefaultsStore.shared.separatorSymbol

}

// MARK: - Views
extension SeparatorSelectorView {
    var body: some View {
        HStack(spacing: 10) {
            Picker(selection: $currentSeparator, label: EmptyView()) {
                ForEach(SeparatorSymbol.allCases) { separator in
                    Text(String(separator.symbol))
                        .font(fPasswordFontMedium)
                        .bold()
                        .tag(separator)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .onChange(of: currentSeparator, perform: { newValue in setCurrentSeparator(newValue)})
    }
}

// MARK: - Functions
extension SeparatorSelectorView {
    func setCurrentSeparator(_ separator: SeparatorSymbol) {
        appState.setCurrentSeparator(separator)
        currentSeparator = separator
    }
}

// MARK: - Preview
#if DEBUG
struct SeparatorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorSelectorView()
            .environmentObject(AppState())
    }
}
#endif
