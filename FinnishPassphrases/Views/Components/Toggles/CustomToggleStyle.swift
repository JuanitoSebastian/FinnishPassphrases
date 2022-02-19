//
//  CustomToggleStyle.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 16.1.2022.
//

import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {

    private let flickerBackgroundColor = Color("flicker-background")
    private let flickerBackgroundColorActive = Color("flicker-background :active")

    private let toggleBackgroundColor = Color("toggle-background")
    private let toggleBackgroundColorActive = Color("toggle-background :active")

    private let toggleStrokeColor = Color("toggle-stroke")
    private let toggleStrokeColorActive = Color("toggle-stroke :active")

    private let toggleLineColor = Color("toggle-line")

    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(configuration.isOn ? flickerBackgroundColorActive : flickerBackgroundColor)
                    .frame(width: 40, height: 40)

                HStack {
                    if configuration.isOn { Spacer() }

                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(configuration.isOn ? toggleBackgroundColorActive : toggleBackgroundColor)
                            .frame(width: 17, height: 32)

                        RoundedRectangle(cornerRadius: 4)
                            .stroke(configuration.isOn ? toggleStrokeColorActive : toggleStrokeColor, lineWidth: 2)
                            .frame(width: 15, height: 30)

                        RoundedRectangle(cornerRadius: 2)
                            .stroke(toggleLineColor, lineWidth: 1)
                            .frame(width: 1, height: 18)
                    }

                    if !configuration.isOn { Spacer()}
                }
                .padding(4)
            }
            .frame(maxWidth: 40)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
#if DEBUG
struct CustomToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("", isOn: .constant(false))
            .toggleStyle(CustomToggleStyle())
    }
}
#endif
