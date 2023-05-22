//
//  ContentView.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var appState: AppState
    let slides = [
        Slide(id: 0, imageName: "image1", title: "Welcome to ChatBot", description: "ChatBot is an intelligent virtual assistant designed to provide helpful information and engage in conversations with users."),
        Slide(id: 1, imageName: "image2", title: "Personalized Recommendations", description: "ChatBot analyzes user preferences and behaviors to deliver personalized recommendations for various products and services."),
        Slide(id: 2, imageName: "image3", title: "24/7 Support", description: "ChatBot is available round the clock to assist you with any questions or issues you may have. It offers prompt and reliable support.")
    ]
    
    init() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .green
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.green.withAlphaComponent(0.2)
   }

    var body: some View {
        VStack {
            if self.isActive {
                if settings.loggedIn {
                    AnyView(
                        withAnimation {
                            MainView()
                                .transition(.scale)
                        }
                    )
                } else {
                    VStack {
                        TabView {
                            ForEach(slides) { slide in
                                SlideView(slide: slide)
                            }
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page)

                        Spacer()

                        Button {
                            appState.moveToMain.toggle()
                            settings.loggedIn.toggle()
                        } label: {
                            Text(LETS_START)
                        }
                        .buttonStyle(PrimaryButton())
                    }
                    .padding()
                }
            } else {
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
            .environmentObject(AppState())
    }
}
