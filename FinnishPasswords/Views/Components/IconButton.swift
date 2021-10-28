//
//  IconButton.swift
//  FinnishPasswords
//
//  Created by Juan Covarrubias on 27.10.2021.
//

import SwiftUI

struct IconButton: View {

    let icon: Image
    let action: () -> Void
    let font: Font = .system(size: 14, weight: .bold)
    @State var backgroundColor: Color = cIconButtonBackgroundColor
    @State var rotation: Double = 0
    @State var midAnimation: Bool = false

}

// MARK: - Views
extension IconButton {

    var body: some View {
        Button {
            handleOnClick()
        } label: {
            icon
                .font(font)
                .padding(5)
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            Circle().foregroundColor(backgroundColor)
        )
        .rotationEffect(.degrees(rotation))
        .onHover(perform: { hovering in
            handleOnHover(hovering: hovering)
        })
    }
}

// MARK: - Functions
extension IconButton {

    private func handleOnHover(hovering: Bool) {
        withAnimation(cHoverAnimation) {
            if hovering {
                backgroundColor = cIconButtonBackgroundColorHover
                return
            }
            backgroundColor = cIconButtonBackgroundColor
        }
    }

    private func handleOnClick() {
        action()
        midAnimation = true
        withAnimation(cIconClickAnimation) {
            rotation = -360
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            rotation = 0
            midAnimation = false
        }
    }
}

// MARK: - Preview
#if DEBUG
struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(icon: Image(systemName: "gearshape"), action: {})
    }
}
#endif
