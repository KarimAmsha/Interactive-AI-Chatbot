//
//  AppState.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var isAnimating: Bool = false
    @Published var shouldAnimating: Bool = false
    @Published var showingSucessToast: Bool = false
    @Published var showingErrorToast: Bool = false
    @Published var showingLogoutView: Bool = false
    @Published var toastMessage: String = ""
    @Published var moveToMain = false
    @Published var moveToRecordingView: Bool = false

    init() {
        
    }
    
    func showingActivityIndicator(_ status: Bool) {
        shouldAnimating = status
    }
    
    func showSuccessToast(_ msg: String) {
        shouldAnimating = false
        showingSucessToast = true
        showingErrorToast = false
        toastMessage = msg
    }
    
    func showErrorToast(_ msg: String) {
        shouldAnimating = false
        showingErrorToast = true
        showingSucessToast = false
        toastMessage = msg
    }
    
    func cleanToasts() {
        showingSucessToast = false
        showingErrorToast = false
        toastMessage = ""
    }
}

