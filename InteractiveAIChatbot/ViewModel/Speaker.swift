//
//  Speaker.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 22.05.2023.
//

import AVKit

class Speaker: NSObject, ObservableObject {
    let synth = AVSpeechSynthesizer()
    @Published var isFinished = false
    @Published var isPaused = true

    override init() {
        super.init()
        synth.delegate = self
    }

    func speak(_ string: String, _ language: String) {
        if synth.isSpeaking {
            // when synth is already speaking or is in paused state
            if synth.isPaused {
                synth.continueSpeaking()
                self.isPaused = false
            } else {
                synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
                self.isPaused = true
            }
        } else {
            let utterance = AVSpeechUtterance(string: string)
    //        utterance.pitchMultiplier = 1.0
    //        utterance.rate = 0.5
//            utterance.voice = AVSpeechSynthesisVoice(language: language)
            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Ting-Ting-compact")
            synth.speak(utterance)
            self.isPaused = false
        }
    }
    
    func stop() {
        synth.stopSpeaking(at: .immediate)
//        synth.stopSpeaking(at: .word)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("all done")
        isFinished = true
//        print("mutableAttributedString1 \(NSAttributedString(string: utterance.speechString))")
    }
    
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
//        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
//        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
//        print("mutableAttributedString2 \(mutableAttributedString)")
//    }
    
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
//        lblText.attributedText = NSAttributedString(string: utterance.speechString)
//    }
}
