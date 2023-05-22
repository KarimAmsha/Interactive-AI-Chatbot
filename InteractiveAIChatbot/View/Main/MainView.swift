//
//  MainView.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI
import Speech
import AVFoundation
import PopupView

struct MainView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userInput = ""
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.messages, id: \.text) { message in
                        Text(message.text)
                            .padding(10)
                            .background(message.isUser ? Color.primary() : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(5)
                            .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
                    }
                }
                .padding()
                
                VStack {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: 0.5)
                    .background(Color.grayBBBACD().opacity(0.51))
                    .padding(.top, -d8)

                    HStack {
                        Button(action: {
                            appState.moveToRecordingView.toggle()
                        }) {
                            Image(systemName: "mic.fill")
                                .font(.title)
                                .foregroundColor(.primary())
                                .padding()
                        }
                        
                        VStack {
                            TextField("Type your message", text: $userInput)
                                .customFont(weight: .medium, size: s14)
                                .foregroundColor(.gray7A7A7A())
                                .frame(height: d40)
                                .padding(.horizontal, d18)
                        }
                        .background(Color.grayF8F8F8().cornerRadius(d22))
                        .border(.grayE1E1E1(), width: 1, cornerRadius: d22)

                        Button(action: {
                            guard !userInput.isEmpty else { return }
                            viewModel.embeddingMessage(userInput)
//                            viewModel.sendMessage(userInput)
//                            viewModel.sendCompletionMessage(userInput)
                            userInput = ""
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.title)
                                .foregroundColor(.primary())
                                .padding()
                        }
                    }
//                    .padding()
                }
                .background(Color.white)
            }
            .navigationBarTitle("ChatBot View")
            .navigationBarColor(backgroundColor: UIColor(hexString: "439D7D"), titleColor: .white, showShadow: false)
            .popup(isPresented: $appState.moveToRecordingView) {
                RecordingView()
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(false)
                    .closeOnTap(false)
                    .backgroundColor(.black.opacity(0.5))
            }
        }
    }
    
    func convertVoiceToText() -> String {
        var convertedText = ""

        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        let audioSession = AVAudioSession.sharedInstance()
        let audioEngine = AVAudioEngine()

        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error)")
            return convertedText
        }

        let request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.inputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("Failed to start audio engine: \(error)")
            return convertedText
        }

        recognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                convertedText = result.bestTranscription.formattedString
            } else if let error = error {
                print("Recognition task error: \(error)")
            }
        }
        
        print("convertedText \(convertedText)")

        return convertedText
    }

    func processText(_ text: String) -> String {
        var res = ""
        
        // Set up the API request
        let apiKey = "YOUR_API_KEY"
        let apiUrl = URL(string: "https://api.openai.com/v1/your-api-endpoint")!
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the request body
        let requestBody = ["text": text]
        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        
        // Send the API request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API request error: \(error)")
                return
            }
            
            // Process the API response
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    res = json?["response"] as? String ?? ""
                } catch {
                    print("Failed to process API response: \(error)")
                }
            }
        }
        task.resume()
        
        return res
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppState())
            .environmentObject(AudioRecorder())
            .environmentObject(SwiftUISpeech())
    }
}
