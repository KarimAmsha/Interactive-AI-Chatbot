//
//  SplashView.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("ic_logo")
                .resizable()
                .frame(width: UIScreen.screenWidth/3.5, height: UIScreen.screenWidth/3.5, alignment: .center)
                .cornerRadius(d10)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
