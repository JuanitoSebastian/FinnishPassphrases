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

    let backdropColor = Color("about-background")
    let titleColor = Color("about-text-heading")
    let bodyTextColor = Color("about-text-body")
    let ballColor = Color("about-ball")
    let checkboxWrapperColor = Color("about-element-wrapper")

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backdropColor)

            blurredCircle
                .position(x: 0, y: cAboutWindowHeight)

            blurredCircle
                .position(x: cAboutWindowWidth, y: 0)

            mainContent
                .padding(contentPadding)
        }
        .frame(width: cAboutWindowWidth, height: cAboutWindowHeight)
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
            RoundedSquareWrapper(padding: EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)) {
                Toggle(LocalizedStringKey("aboutWindowCheckbox"), isOn: $appState.doNotShowAboutWindowOnStart)
                    .toggleStyle(CustomCheckboxStyle())
            }
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
