//
//  CustomLabel.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 1.3.2022.
//

import Foundation
import SwiftUI

struct CustomLabelStyle: LabelStyle {

  let iconColor = Color("button-symbol")
  let textColor = Color("button-text")
  let labelFont = Font.system(size: 14, design: .rounded).weight(.medium)
  let iconFont = Font.system(size: 12).weight(.medium)

  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 6) {
      configuration.icon
        .font(iconFont)
        .foregroundColor(iconColor)

      configuration.title
        .foregroundColor(textColor)
        .font(labelFont)
    }
    .contentShape(Rectangle())
  }

}
