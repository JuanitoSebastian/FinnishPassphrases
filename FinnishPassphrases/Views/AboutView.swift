//
//  AboutView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.12.2021.
//

import SwiftUI
import AppKit

/// A view describing the application. Displayed in the about window which is
/// displayed when the app is first opened.
struct AboutView: View {

  @ObservedObject var appState: AppState

  private let contentPadding: EdgeInsets = EdgeInsets(
    top: 16,
    leading: 24,
    bottom: 24,
    trailing: 24
  )

  let backdropColor = Color("about-background")
  let titleColor = Color("about-text-heading")
  let bodyTextColor = Color("about-text-body")
  let ballColor = Color("about-ball")
  let checkboxWrapperColor = Color("about-element-wrapper")

  let headingFont = Font.system(.largeTitle, design: .rounded).weight(.semibold)
  let bodyFont = Font.system(.body, design: .default)
  let captionFont = Font.system(.caption, design: .rounded)
}

// MARK: - Views
extension AboutView {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(backdropColor)

      blurredCircle
        .position(x: 0, y: 0)

      blurredCircle
        .position(x: cAboutWindowWidth, y: cAboutWindowHeight)

      mainContent
        .padding(contentPadding)
    }
  }

  private var mainContent: some View {
    VStack(alignment: .center, spacing: 20) {
      Image("FinnishPassphrasesIcon")
        .resizable()
        .scaledToFit()
        .frame(width: 300)

      Text(LocalizedStringKey("appNameTitle"))
        .font(headingFont)
        .foregroundColor(titleColor)

      HStack(spacing: 16) {
        Spacer()

        Text(LocalizedStringKey("appVersion \(appState.appVersion)"))
          .foregroundColor(bodyTextColor)
          .font(captionFont)

        Text(LocalizedStringKey("appDevelopedBy"))
          .foregroundColor(bodyTextColor)
          .font(captionFont)

        Spacer()
      }

      Text(LocalizedStringKey("aboutWindowAppDescription"))
        .foregroundColor(bodyTextColor)
        .multilineTextAlignment(.center)
        .font(bodyFont)
        .lineSpacing(6)

      Spacer()

      Text(LocalizedStringKey("aboutWindowWordsSource"))
        .foregroundColor(bodyTextColor)
        .font(captionFont)

    }
  }

  private var blurredCircle: some View {
    Circle()
      .foregroundColor(ballColor)
      .frame(width: 100, height: 100)
      .blur(radius: 30)
  }
}
