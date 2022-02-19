//
//  CustomToggleStyle.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 16.1.2022.
//

import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {

    private let movingSwitchFillColor = Color("lighter-blue")
    private let movingSwitchStrokeColor = Color("light-blue")

    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            ZStack(alignment: .center) {
                square

                HStack {
                    if configuration.isOn { Spacer() }
                    movingSwitch
                    if !configuration.isOn { Spacer()}
                }
                .padding(4)
            }
            .frame(maxWidth: 40)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var square: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: 40, height: 40)
    }

    private var movingSwitch: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 4)
                .fill(movingSwitchFillColor)
                .frame(width: 17, height: 32)

            RoundedRectangle(cornerRadius: 4)
                .stroke(movingSwitchStrokeColor, lineWidth: 2)
                .frame(width: 15, height: 30)

            RoundedRectangle(cornerRadius: 2)
                .stroke(movingSwitchStrokeColor, lineWidth: 1)
                .frame(width: 1, height: 18)
        }
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
