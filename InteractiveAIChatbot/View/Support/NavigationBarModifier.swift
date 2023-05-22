//
//  NavigationBarModifier.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?
    var showShadow: Bool?

    init(backgroundColor: UIColor?, titleColor: UIColor?, showShadow: Bool?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black, .font: UIFont(name: FontWeight.regular.rawValue, size: s17)!]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black, .font: UIFont(name: FontWeight.medium.rawValue, size: s30)!]
        if showShadow ?? false {
            coloredAppearance.shadowColor = UIColor(Color.gray707070())
        }

//        let backImage = UIImage(systemName: "chevron.left.circle.fill")?.withTintColor(UIColor(Color.black26293B()), renderingMode: .alwaysOriginal)
        let backImage = UIImage(named: "ic_back")//?.withTintColor(UIColor(Color.black26293B()), renderingMode: .alwaysOriginal)
        coloredAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = titleColor ?? .black
        UINavigationBar.appearance().barTintColor = titleColor ?? .black
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?, showShadow: Bool?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor, showShadow: showShadow))
    }

}
