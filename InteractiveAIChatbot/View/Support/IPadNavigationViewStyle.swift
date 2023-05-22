//
//  IPadNavigationViewStyle.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import SwiftUI

struct IPadNavigationViewStyle: ViewModifier {
    func body(content: Content) -> some View { content.navigationViewStyle(StackNavigationViewStyle()) }
}

struct IPhoneNavigationViewStyle: ViewModifier {
    func body(content: Content) -> some View { content.navigationViewStyle(DefaultNavigationViewStyle()) }
}

extension View {
    public func modify<T, U>(if condition: Bool, then modifierT: T, else modifierU: U) -> some View where T: ViewModifier, U: ViewModifier {
        Group {
            if condition {
                modifier(modifierT)
            } else {
                modifier(modifierU)
            }
        }
    }
}
