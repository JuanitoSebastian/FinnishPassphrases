//
//  RoundedSquareWrapper.swift
//  FinnishPassphrases
//
//  Created by Juan Covarrubias on 19.2.2022.
//

import SwiftUI

/// A reusable wrapper for content
struct RoundedSquareWrapper<Content: View>: View {

  private let builder: () -> Content
  private let padding: EdgeInsets
  private let background: Color

  init(
    padding: EdgeInsets = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
    background: Color = Color("wrapper-background"),
    builder: @escaping () -> Content
  ) {
    self.builder = builder
    self.padding = padding
    self.background = background
  }

  var body: some View {
    ZStack {
      builder()
        .padding(padding)
    }
    .background(background)
    .cornerRadius(10)
  }
}

#if DEBUG
struct RoundedSquareWrapper_Previews: PreviewProvider {
  static var previews: some View {
    RoundedSquareWrapper {
      Text("This is a wrapper")
    }
  }
}
#endif
