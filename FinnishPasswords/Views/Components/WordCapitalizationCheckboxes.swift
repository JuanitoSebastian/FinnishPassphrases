//
//  WordCapitalizationCheckboxes.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 18.8.2021.
//

import SwiftUI

struct WordCapitalizationCheckboxes: View {

    @State var bool: Bool = true

    var body: some View {
        HStack {
            Checkbox(checked: $bool, description: "Vaihteleva kirjainkoko")
        }
    }
}

struct WordCapitalizationCheckboxes_Previews: PreviewProvider {
    static var previews: some View {
        WordCapitalizationCheckboxes()
    }
}
