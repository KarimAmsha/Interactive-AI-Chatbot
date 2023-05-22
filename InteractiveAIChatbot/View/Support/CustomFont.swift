//
//  CustomFont.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    var weight: FontWeight
    var size: CGFloat

    func body(content: Content) -> some View {
        return content.font(Font.custom(
                                weight.rawValue,
                                size: size))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func customFont(
        weight: FontWeight = .regular,
        size: CGFloat) -> some View {
        return self.modifier(CustomFont(weight: weight, size: size))
    }
}
