//
//  WordCapitalizationCheckboxes.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 18.8.2021.
//

import SwiftUI

struct WordCapitalizationCheckboxes: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            Checkbox(checked: $appState.capitalization, description: "Vaihteleva kirjainkoko")
        }
    }
}

struct WordCapitalizationCheckboxes_Previews: PreviewProvider {
    static var previews: some View {
        WordCapitalizationCheckboxes()
    }
}
