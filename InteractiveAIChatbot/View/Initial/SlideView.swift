//
//  SlideView.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

struct SlideView: View {
    let slide: Slide

    var body: some View {
        VStack(alignment: .center, spacing: d10) {
            Image(slide.imageName)
                .resizable()
                .frame(height: 200)
                .cornerRadius(d16)

            Text(slide.title)
                .customFont(weight: .bold, size: s20)
            
            Text(slide.description)
                .customFont(weight: .medium, size: s15)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)            
        }
        .padding()
    }
}

