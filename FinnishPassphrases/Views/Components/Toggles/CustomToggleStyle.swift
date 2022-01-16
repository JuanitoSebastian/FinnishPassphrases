//
//  CustomToggleStyle.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 16.1.2022.
//

import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {

    private let togglePadding = EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6)
    private let ballColorInactive = Color("light-blue")
    private let ballColorActive = Color.white
    private let backgroundColorInactive = Color.white
    private let backgroundColorActive = Color("blue")

    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(configuration.isOn ? backgroundColorActive : backgroundColorInactive)

                HStack {
                    if configuration.isOn {
                        Spacer()
                    }

                    Circle()
                        .fill(configuration.isOn ? ballColorActive  : ballColorInactive)
                        .frame(width: 22, height: 22)

                    if !configuration.isOn {
                        Spacer()
                    }
                }
                .padding(togglePadding)

            }
            .frame(width: 60, height: 20)
        }
        .buttonStyle(PlainButtonStyle())
    }

}
