//
//  Languages.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 22.05.2023.
//

import SwiftUI

struct Languages: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var code: String
    
    static var getAllLanguages: [Languages] {
        return [
            Languages(id: "01", name: "French", code: "fr"),
            Languages(id: "02", name: "Italian", code: "it"),
            Languages(id: "03", name: "German", code: "de"),
            Languages(id: "04", name: "Japanese", code: "ja"),
            Languages(id: "05", name: "Korean", code: "ko"),
            Languages(id: "06", name: "Portuguese", code: "pt"),
            Languages(id: "07", name: "Russian", code: "ru"),
            Languages(id: "08", name: "Spanish", code: "es"),
            Languages(id: "09", name: "English", code: "en-US"),
            Languages(id: "10", name: "Arabic", code: "ar-SA"),
        ]
    }
}

