//
//  WordDisplayerView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 29.5.2021.
//

import SwiftUI
import WrappingHStack

/// A view that displayes a given passphrase
struct PassphraseDispalyerView: View {

  @Binding var passphrase: Passphrase

  private let passphraseTextPadding = EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
  private let passphraseAreaPadding = EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)

  private let passphraseFont = Font.system(size: 18, design: .monospaced).weight(.regular)
  private let passphraseWordColor = Color("passphrase-text")
  private let passphraseSeparatorColor = Color("passphrase-separator")

}

// MARK: - Views
extension PassphraseDispalyerView {

  var body: some View {
    VStack(alignment: .leading) {
      WrappingHStack(
        0..<passphrase.numOfWords,
        id: \.self,
        alignment: .leading,
        spacing: .constant(1)
      ) {
        Text(passphrase.words[$0])
          .font(passphraseFont)
          .foregroundColor(passphraseWordColor)
          .padding(passphraseTextPadding)
        if $0 < (passphrase.numOfWords - 1) {
          Text(String(passphrase.separator.symbol))
            .font(passphraseFont)
            .foregroundColor(passphraseSeparatorColor)
            .padding(passphraseTextPadding)
        }
      }
      .padding(passphraseAreaPadding)

      Spacer()

    }
  }
}
