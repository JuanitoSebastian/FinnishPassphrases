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
    let actionAnimated: Bool
    let font: Font
    let iconColor: Color
    let iconColorHover: Color
    @State private var hover: Bool
    @State private var rotation: Double
    @State private var midAnimation: Bool

    init(
        icon: Image,
        action: @escaping () -> Void,
        actionAnimated: Bool = false,
        iconColor: Color = Color("dark-blue"),
        iconColorHover: Color = Color("black")
    ) {
        self.icon = icon
        self.action = action
        self.font = Font.system(size: 14, weight: .semibold)
        self.actionAnimated = actionAnimated
        self.iconColor = iconColor
        self.iconColorHover = iconColorHover
        self.hover = false
        self.rotation = 0
        self.midAnimation = false
    }

}

// MARK: - Views
extension IconButton {

    var body: some View {
        Button {
            handleOnClick()
        } label: {
            icon
            .font(font)
            .foregroundColor(hover ? iconColorHover : iconColor)
            .frame(width: 30, height: 30)
            .contentShape(Circle())
        }
        .buttonStyle(PlainButtonStyle())
        .rotationEffect(.degrees(rotation))
        .onHover(perform: { hovering in
            withAnimation {
                hover = hovering
            }
        })
    }
}

// MARK: - Functions
extension IconButton {

    private func handleOnClick() {
        action()

        guard actionAnimated else { return }
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
