//
//  ChatViewModel.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import SwiftUI
import OpenAI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var chats: [Chat] = []
    @Published var completionText = ""
    @Published var str = ""
    @Published var audioCompletionText = ""
    let apiKey = "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"
    
    func sendVoiceMessage(_ message: String) {
        messages.append(Message(text: message, isUser: true))

        guard let audioURL = Bundle.main.url(forResource: "Record", withExtension: "mp3") else {
            print("Audio file not found in the app bundle.")
            return
        }

        let audioData = try! Data(contentsOf: audioURL)
        let audioBase64 = audioData.base64EncodedString()

        let payload: [String: Any] = [
            "config": [
                "model": "whisper",
            ],
            "audio": audioBase64
        ]

        let url = URL(string: "https://api.openai.com/v1/audio/translations")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("org-osIyzIgaNfzce9L0KzJDLHT9", forHTTPHeaderField: "OpenAI-Organization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: payload)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                print("dddd \(response)")
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                   let responseDict = responseJSON as? [String: Any],
                   let transcription = responseDict["transcription"] as? String {
                       print("Transcription: \(transcription)")
                } else {
                    print("Invalid response format")
                }
            } else {
                print("No response data")
            }
        }

        task.resume()
    }
    
    func sendMessage(_ message: String) {
        messages.append(Message(text: message, isUser: true))
        let apiKey = "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"
        let endpoint = "https://api.openai.com/v1/engines/davinci/completions"

        guard let url = URL(string: endpoint) else {
            print(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = message//messages.map { $0.text }.joined(separator: "\n")
        let requestData: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 100,
            "temperature": 0.6
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: []) else {
            print(NSError(domain: "Invalid request data", code: 0, userInfo: nil))
            return
        }

        request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data,
                  let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                  let responseDict = responseJSON as? [String: Any] else {
                print(NSError(domain: "Invalid response data", code: 0, userInfo: nil))
                return
            }
            
            // Debugging: Print the response dictionary
//            print(responseDict)

            if let choices = responseDict["choices"] as? [[String: Any]],
               let completionText = choices.first?["text"] as? String {
                DispatchQueue.main.async {
                    self.messages.append(Message(text: completionText, isUser: false))
                }
            } else {
                print(NSError(domain: "Invalid response format", code: 0, userInfo: nil))
            }
        }

        task.resume()
    }

    func makeAPIRequest(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let apiKey = "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"
        let endpoint = "https://api.openai.com/v1/engines/davinci/completions"

        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 50
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: []) else {
            completion(.failure(NSError(domain: "Invalid request data", code: 0, userInfo: nil)))
            return
        }

        request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                  let responseDict = responseJSON as? [String: Any] else {
                completion(.failure(NSError(domain: "Invalid response data", code: 0, userInfo: nil)))
                return
            }
            
            // Debugging: Print the response dictionary
            print(responseDict)

            if let choices = responseDict["choices"] as? [[String: Any]],
               let completionText = choices.first?["text"] as? String {
                completion(.success(completionText))
            } else {
                completion(.failure(NSError(domain: "Invalid response format", code: 0, userInfo: nil)))
            }
        }

        task.resume()
    }
    
    func sendChatMessage(_ message: String) {
        chats.append(Chat(role: .user, content: message))
        let openAI = OpenAI(apiToken: "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")

        let q = ChatQuery(model: .gpt3_5Turbo0301, messages: self.chats)
        openAI.chats(query: q) { result in
            //Handle result here
              print("ressss \(result.map({$0.choices.first?.message}))")
            let completionText = result.map({$0.choices.first?.message})
              switch completionText {
              case .success(let text):
                  if let text = text {
                      // Use the extracted string
                      print("Completion text: \(text)")
                      DispatchQueue.main.async {
                          self.chats.append(Chat(role: .system, content: text.content))
                      }
                  } else {
                      // Handle case where the result is nil
                      print("Completion text is nil")
                      DispatchQueue.main.async {
//                          self.messages.append(Message(text: "text is nil", isUser: false))
                          self.chats.append(Chat(role: .system, content: "text is nil"))
                      }
                  }
              case .failure(let error):
                  // Handle the error case
                  print("Error: \(error.localizedDescription)")
                  DispatchQueue.main.async {
                      self.chats.append(Chat(role: .system, content: error.localizedDescription))
                  }
              }
          }

    }
    
    func sendCompletionMessage(_ message: String) {
        let userMessage = Message(text: message, isUser: true)
        messages.append(userMessage)
        let openAI = OpenAI(apiToken: "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")
        
        let documents = messages.map { $0.text }.joined(separator: "\n")

        let query = CompletionsQuery(model: .textDavinci_003, prompt: documents, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
            openAI.completions(query: query) { result in
                print("ressss \(result.map({$0.choices.first?.text}))")
                let completionText = result.map({$0.choices.first?.text})
                switch completionText {
                case .success(let text):
                    if let text = text {
                        print("Completion text: \(text)")
                        DispatchQueue.main.async {
                            self.messages.append(Message(text: text, isUser: false))
                        }
                    } else {
                        print("Completion text is nil")
                        DispatchQueue.main.async {
                            self.messages.append(Message(text: "text is nil", isUser: false))
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.messages.append(Message(text: error.localizedDescription, isUser: false))
                    }
                }
            }
    }
    
    func embeddingMessage(_ message: String) {
        let userMessage = Message(text: message, isUser: true)
        messages.append(userMessage)
        let openAI = OpenAI(apiToken: "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")
        
        let documents = messages.map { $0.text }.joined(separator: "\n")

        let query = EmbeddingsQuery(model: .textEmbeddingAda, input: documents)
        openAI.embeddings(query: query) { result in
                print("ressss \(result.map({$0.data.first?.embedding}))")
            let completionText = result.map({$0.data.first?.embedding})
                switch completionText {
                case .success(let text):
                    if let text = text {
                        print("Completion text: \(text)")
                        DispatchQueue.main.async {
                            let query = CompletionsQuery(model: .textDavinci_003, prompt: documents, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
                                openAI.completions(query: query) { result in
                                    print("ressss \(result.map({$0.choices.first?.text}))")
                                    let completionText = result.map({$0.choices.first?.text})
                                    switch completionText {
                                    case .success(let text):
                                        if let text = text {
                                            print("Completion text: \(text)")
                                            DispatchQueue.main.async {
                                                self.messages.append(Message(text: text, isUser: false))
                                                self.audioCompletionText = text
                                            }
                                        } else {
                                            print("Completion text is nil")
                                            DispatchQueue.main.async {
                                                self.messages.append(Message(text: "text is nil", isUser: false))
                                            }
                                        }
                                    case .failure(let error):
                                        print("Error: \(error.localizedDescription)")
                                        DispatchQueue.main.async {
                                            self.messages.append(Message(text: error.localizedDescription, isUser: false))
                                        }
                                    }
                                }
                        }
                    } else {
                        print("Completion text is nil")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }

    func sendAudioMessage(_ message: String) {
        let userMessage = Message(text: message, isUser: true)
        messages.append(userMessage)
        let openAI = OpenAI(apiToken: "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")
        
        let query = CompletionsQuery(model: .textDavinci_003, prompt: message, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
            openAI.completions(query: query) { result in
                print("ressss \(result.map({$0.choices.first?.text}))")
                let completionText = result.map({$0.choices.first?.text})
                switch completionText {
                case .success(let text):
                    if let text = text {
                        print("Completion text: \(text)")
                        DispatchQueue.main.async {
                            self.messages.append(Message(text: text, isUser: false))
                            self.audioCompletionText = text
                        }
                    } else {
                        print("Completion text is nil")
                        DispatchQueue.main.async {
                            self.messages.append(Message(text: "text is nil", isUser: false))
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.messages.append(Message(text: error.localizedDescription, isUser: false))
                    }
                }
            }
    }

    
    func translateAudio(audioURL: URL) {
        guard let audioData = try? Data(contentsOf: audioURL) else {
            print("Failed to read audio file")
            return
        }
        
        let openAI = OpenAI(apiToken: "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")
        
        let query = AudioTranslationQuery(file: audioData, fileName: "audio.m4a", model: .whisper_1, prompt: self.str, temperature: 0.6)
        openAI.audioTranslations(query: query)  { result in
            let completionText = result.map({$0.text})
            switch completionText {
            case .success(let text):
                DispatchQueue.main.async {
                    self.completionText = text
                    self.str = "\(self.str) \n \(text)"
//                    print("Completion text: \(self.completionText)")
//                    print("str text: \(self.str)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.completionText = error.localizedDescription
                }
            }
        }
//        guard let apiKeyData = apiKey.data(using: .utf8) else {
//            print("Invalid API key")
//            return
//        }
//
//        let model = "whisper-1.0" 
//
//        // Prepare the API request URL
//        let baseURL = "https://api.openai.com/v1/audio/translations"
//        guard let url = URL(string: baseURL) else {
//            print("Invalid URL")
//            return
//        }
//
//        // Create the API request
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(apiKeyData)", forHTTPHeaderField: "Authorization")
//
//        // Read the audio file data
//        guard let audioData = try? Data(contentsOf: audioURL) else {
//            print("Failed to read audio file")
//            return
//        }
//
//        // Set the request body
//        let boundary = UUID().uuidString
//        let boundaryLine = "--\(boundary)\r\n"
//        let boundaryClosingLine = "--\(boundary)--\r\n"
//        let contentType = "multipart/form-data; boundary=\(boundary)"
//
//        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
//
//        let body = NSMutableData()
//        body.appendString(boundaryLine)
//        body.appendString("Content-Disposition: form-data; name=\"model\"\r\n\r\n")
//        body.appendString(model)
//        body.appendString("\r\n")
//
//        body.appendString(boundaryLine)
//        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"audio_file\"\r\n")
//        body.appendString("Content-Type: audio/x-m4a\r\n\r\n")
//        body.append(audioData)
//        body.appendString("\r\n")
//
//        body.appendString(boundaryClosingLine)
//
//        // Set the request body data
//        request.httpBody = body as Data

//         Send the API request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            // Parse and process the API response
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Response: \(responseString)")
//                // Handle the response data here
//            }
//        }
//
//        task.resume()

//        if let data = try? Data(contentsOf: audioURL) {
//            let openAI = OpenAI(apiToken: "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")
//
//            let model = "whisper-1" // Specify the Whisper model version here
//
//            // Prepare the API request URL
//            let baseURL = "https://api.openai.com/v1/audio/translations"
//
//            guard let url = URL(string: baseURL) else {
//                print("Invalid URL")
//                return
//            }
//            print("audioURL \(audioURL)")
//
//            // Create the API request payload
//            let payload: [String: Any] = [
//                "source_language": sourceLanguage,
//                "target_language": targetLanguage,
//                "file": audioURL.absoluteString,
//                "model": "whisper-1" // Replace with the desired model name or variant
//            ]
//
//            // Serialize the payload as JSON data
//            guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
//                print("Failed to serialize JSON data")
//                return
//            }
//
//            // Create the API request
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//
//            // Send the API request
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let data = data else {
//                    print("No data received")
//                    return
//                }
//
//                // Parse and process the API response
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                    // Handle the response data here
//                }
//            }
//
//            task.resume()
//        }
    }
}
