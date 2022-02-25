//
//  CustomCheckboxStyle.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 20.2.2022.
//

import Foundation
import SwiftUI

struct CustomCheckboxStyle: ToggleStyle {

  private let backgroundColor = Color("checkbox-background")
  private let checkmarkColor = Color("checkbox-checkmark")
  let textColor = Color("about-text-body")
  let textFont = Font.system(.body, design: .rounded)

  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      HStack(spacing: 8) {
        ZStack(alignment: .center) {
          RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
            .fill(backgroundColor)

          if configuration.isOn {
            Image(systemName: "checkmark")
              .font((.system(size: 18, weight: .bold)))
              .foregroundColor(checkmarkColor)
          }
        }
        .frame(width: 22, height: 22)
        .padding(.trailing, 2)

        configuration.label
          .font(textFont)
          .foregroundColor(textColor)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }
}
