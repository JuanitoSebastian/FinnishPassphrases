//
//  AboutView.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 31.12.2021.
//

import SwiftUI

struct AboutView: View {

    @ObservedObject var appState: AppState

    private let contentPadding: EdgeInsets = EdgeInsets(
        top: 15,
        leading: 25,
        bottom: 25,
        trailing: 25
    )

    let titleColor = Color("black")
    let bodyTextColor = Color("gray")
    let ballColor = Color("light-blue")
    let checkboxWrapperColor = Color("lighter-blue")

    var body: some View {
        ZStack {
            background

            blurredCircle
                .position(x: 0, y: cAboutWindowHeight)

            blurredCircle
                .position(x: cAboutWindowWidth, y: 0)

            mainContent
                .padding(contentPadding)
        }
        .frame(width: cAboutWindowWidth, height: cAboutWindowHeight)
    }

    private var background: some View {
        Rectangle()
            .fill(
                Color.white
            )
    }

    private var mainContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(LocalizedStringKey("appNameTitle"))
                    .font(cUiTitleFont)
                    .foregroundColor(titleColor)
                Spacer()
            }
            HStack {
                Text(LocalizedStringKey("aboutWindowAppDescription"))
                    .foregroundColor(bodyTextColor)
                    .font(cUiAppDescriptionFont)
                    .lineSpacing(6)
            }
            ZStack {
                Checkbox(
                    checked: $appState.doNotShowAboutWindowOnStart,
                    description: LocalizedStringKey("aboutWindowCheckbox")
                )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
            }
            .background(checkboxWrapperColor)
            .cornerRadius(10)
            Spacer()
        }
    }

    private var blurredCircle: some View {
        Circle()
            .foregroundColor(ballColor)
            .frame(width: 100, height: 100)
            .blur(radius: 30)
    }
}

// MARK: - Preview
#if DEBUG
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(appState: AppState.previewShared)
    }
}
#endif
