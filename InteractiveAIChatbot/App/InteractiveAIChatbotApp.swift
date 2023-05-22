//
//  InteractiveAIChatbotApp.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

@main
struct InteractiveAIChatbotApp: App {
    
    var body: some Scene {
        WindowGroup {
            let appState = AppState()
            let settings = UserSettings()

            ContentView()
                .environment(\.colorScheme, .light)
                .environmentObject(appState)
                .environmentObject(settings)
                .environmentObject(SwiftUISpeech())
                .environmentObject(AudioRecorder())
        }
    }
}
