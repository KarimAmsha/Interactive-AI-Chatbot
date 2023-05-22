//
//  ButtonsStyles.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    var bgColor: Color = .primary()
    var fColor: Color = .white
    var height: CGFloat? = d50
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(bgColor)
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .center)
            .foregroundColor(fColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct UserTypeButton: ButtonStyle {
    var textSize: CGFloat? = d14
    var fontWeight: FontWeight? = .medium
    var selected: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        if selected {
            configuration.label
                .padding()
                .frame(maxWidth: .infinity, maxHeight: d50, alignment: .center)
                .customFont(weight: fontWeight!, size: textSize!)
                .foregroundColor(.white)
                .background(Color.primary())
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        } else {
            configuration.label
                .padding()
                .frame(maxWidth: .infinity, maxHeight: d50, alignment: .center)
                .background(Color.white)
                .customFont(weight: fontWeight!, size: textSize!)
                .foregroundColor(.black202130())
                .overlay(
                    RoundedRectangle(cornerRadius: d25)
                        .stroke(Color.primary(), lineWidth: 1)
                )
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
}

struct PrimaryButton: ButtonStyle {
    var textSize: CGFloat? = d14
    var fontWeight: FontWeight? = .semiBold
    var bgColor: Color? = Color.primary()
    var fgColor: Color? = Color.white
    var height: CGFloat? = d50
    var radius: CGFloat? = d25

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .center)
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(fgColor)
            .background(bgColor.cornerRadius(radius: radius!))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct TransparentButton: ButtonStyle {
    var textSize: CGFloat? = d15
    var fontWeight: FontWeight? = .regular
    var bgColor: Color? = Color.primary()
    var height: CGFloat? = d50
    var radius: CGFloat? = d25

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .center)
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(.primary())
            .background(bgColor.cornerRadius(radius: radius!).opacity(0.20))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct BorderButton: ButtonStyle {
    var textSize: CGFloat? = s15
    var fontWeight: FontWeight? = .regular
    var height: CGFloat? = d50
    var radius: CGFloat? = d25
    var fColor: Color? = .primary()
    var bgColor: Color? = .clear
    var bColor: Color? = .primary()

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .center)
            .background(bgColor)
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(fColor)
            .overlay(
                RoundedRectangle(cornerRadius: radius!)
                    .stroke(bColor!, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct AppleButton: ButtonStyle {
    let textSize: CGFloat? = s14
    var fontWeight: FontWeight? = .regular
    var width: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
//            .frame(maxWidth: .infinity, maxHeight: d50, alignment: .center)
            .frame(width: width, height: d50)
            .background(Color.white)
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(.black202130())
            .border(Color.black202130(), width: 1, cornerRadius: d25)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct FBButton: ButtonStyle {
    let textSize: CGFloat? = s14
    var fontWeight: FontWeight? = .regular
    var width: CGFloat?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
//            .frame(maxWidth: .infinity, maxHeight: d50, alignment: .center)
            .frame(width: width, height: d50)
            .background(Color.blue106BB9())
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CustomButtonStyle: ButtonStyle {
    let pushBackScale: CGFloat
    let fColor: Color
    let textSize: CGFloat
    var fontWeight: FontWeight? = .regular

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? pushBackScale : 1.0)
            .customFont(weight: fontWeight!, size: textSize)
            .foregroundColor(fColor)
    }
}

struct CircleGrowingButton: ButtonStyle {
    var textSize: CGFloat? = d15
    var fontWeight: FontWeight? = .regular
    var bgColor: Color = Color.primary()
    var dim: CGFloat? = d62

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: dim, height: dim, alignment: .center)
            .background(bgColor)
            .customFont(weight: fontWeight!, size: textSize!)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
