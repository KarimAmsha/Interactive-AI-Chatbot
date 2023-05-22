//
//  RecordingView.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import SwiftUI

struct RecordingView: View {
    @State var text = ""
    @EnvironmentObject var audioRecorder: AudioRecorder
    @EnvironmentObject var swiftUISpeech: SwiftUISpeech
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ChatViewModel()
    @StateObject var speaker = Speaker()
    @State private var query: String = ""
    @State private var results: [SearchResult] = []
    private let openAIEndpoint = "https://api.openai.com/v1/"
    private let openAIKey = "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"
    let documents = [
        "Lorem ipsum dolor sit amet.",
        "Consectetur adipiscing elit.",
        "Pellentesque euismod ipsum vel sollicitudin."
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.primary().ignoresSafeArea()

            GeometryReader { gr in
                VStack(spacing: d20) {
                    HStack {
                        Button(action: {
                            appState.moveToRecordingView.toggle()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }

                    ScrollView {
                        Text("\(viewModel.audioCompletionText)")
                        .customFont(weight: .medium, size: s14)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
//                        .lineSpacing(5)
                    }
                    Spacer()
                    if audioRecorder.recording == false {
                        Text("Speak Now")
                            .customFont(weight: .medium, size: s17)
                            .foregroundColor(.white)
                    }
                    
                    swiftUISpeech.getButton()
                        .padding(.top)
                        .padding(.bottom, d50)
                }
                .frame(minWidth: gr.size.width)
            }
            .padding(d16)
        }
        .frame(height: d400)
        .onReceive(audioRecorder.$readyToUpload) { value in
            print("value \(value)")
//            performSemanticSearch()

            if value {
//                appState.moveToRecordingView.toggle()
                viewModel.translateAudio(audioURL: audioRecorder.recordings.last!.fileURL)
                audioRecorder.readyToUpload.toggle()
            }
        }
        .onReceive(viewModel.$completionText) { value in
            print("vvvvv \(value)")
            if !value.isEmpty {
//                viewModel.sendAudioMessage(value)
                viewModel.embeddingMessage(value)
            }
        }
        .onReceive(viewModel.$audioCompletionText) { value in
            if !value.isEmpty {
                if let language = Utilities.detectedLanguage(for: value) {
                    print("mmmmm \(value), llll \(language)")
                    speaker.speak(value, language.code)
                }
            }
        }
    }
    
//    private func performSemanticSearch() {
//        // Step 1: Generate embeddings for documents
//        let documentEmbeddings = generateEmbeddingsForDocuments()
//
//        // Step 2: Generate embeddings for query
//        let queryEmbedding = generateEmbeddingForQuery()
//
//        // Step 3: Perform semantic search
//        results = performSemanticSearch(queryEmbedding, documentEmbeddings)
//    }
//
//    private func generateEmbeddingsForDocuments() -> [DocumentEmbedding] {
//        var documentEmbeddings: [DocumentEmbedding] = []
//
//
//        for document in documents {
//            let requestBody: [String: Any] = [
//                "documents": [document],
//                "options": ["return_embeddings": true]
//            ]
//
//            guard let requestData = try? JSONSerialization.data(withJSONObject: requestBody) else {
//                continue
//            }
//
//            let headers = [
//                "Content-Type": "application/json",
//                "Authorization": "Bearer \(openAIKey)"
//            ]
//
//            let url = URL(string: "\(openAIEndpoint)/engines/davinci-codex/completions")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.allHTTPHeaderFields = headers
//            request.httpBody = requestData
//
//            let semaphore = DispatchSemaphore(value: 0)
//
//            URLSession.shared.dataTask(with: request) { (data, response, error) in
//                defer {
//                    semaphore.signal()
//                }
//
//                guard let data = data else {
//                    return
//                }
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let choices = json?["choices"] as? [[String: Any]], let firstChoice = choices.first, let embeddings = firstChoice["embeddings"] as? [[Double]] {
//                        let documentEmbedding = DocumentEmbedding(document: document, embeddings: embeddings)
//                        documentEmbeddings.append(documentEmbedding)
//                        print("documentEmbeddings \(documentEmbeddings)")
//                    }
//                } catch {
//                    return
//                }
//            }.resume()
//
//            semaphore.wait()
//        }
//
//        return documentEmbeddings
//    }
//
//    private func generateEmbeddingForQuery() -> QueryEmbedding {
//        let query = "What is the capital of France?"
//
//        let requestBody: [String: Any] = [
//            "documents": documents,
//            "query": query,
//            "options": ["return_embeddings": true]
//        ]
//
//        guard let requestData = try? JSONSerialization.data(withJSONObject: requestBody) else {
//            return QueryEmbedding(query: query, embeddings: [])
//        }
//
//        let headers = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(openAIKey)"
//        ]
//
//        let url = URL(string: "\(openAIEndpoint)/engines/davinci/completions")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = requestData
//
//        let semaphore = DispatchSemaphore(value: 0)
//
//        var queryEmbedding: QueryEmbedding?
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            defer {
//                semaphore.signal()
//            }
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                print("jsonjson \(json)")
//                if let choices = json?["choices"] as? [[String: Any]], let firstChoice = choices.first, let embeddings = firstChoice["embeddings"] as? [[Double]] {
//                    queryEmbedding = QueryEmbedding(query: query, embeddings: embeddings)
//                    print("queryEmbedding \(queryEmbedding)")
//                }
//            } catch {
//                return
//            }
//        }.resume()
//
//        semaphore.wait()
//
//        return queryEmbedding ?? QueryEmbedding(query: query, embeddings: [])
//    }
//
//    private func performSemanticSearch(_ queryEmbedding: QueryEmbedding, _ documentEmbeddings: [DocumentEmbedding]) -> [SearchResult] {
//        var searchResults: [SearchResult] = []
//
//        let queryEmbeddings = queryEmbedding.embeddings
//
//        for queryEmbeddingVector in queryEmbeddings {
//            var queryResults: [SearchResult] = []
//
//            for documentEmbedding in documentEmbeddings {
//                let documentEmbeddingVector = documentEmbedding.embeddings[0] // Assuming a single document embedding
//
//                let similarityScore = calculateCosineSimilarity(queryEmbeddingVector, documentEmbeddingVector)
//
//                let searchResult = SearchResult(
//                    document: documentEmbedding.document,
//                    similarity: similarityScore
//                )
//
//                queryResults.append(searchResult)
//            }
//
//            // Sort the search results for this query by similarity score in descending order
//            queryResults.sort { $0.similarity > $1.similarity }
//
//            // Add the top search result for this query to the overall search results
//            if let topResult = queryResults.first {
//                searchResults.append(topResult)
//                print("topResult \(topResult)")
//            }
//        }
//
//        // Sort the overall search results by similarity score in descending order
//        searchResults.sort { $0.similarity > $1.similarity }
//        print("searchResults \(searchResults)")
//        return searchResults
//    }
    
//    private func performSemanticSearch(_ query: String, _ documents: [String]) -> [SearchResult] {
//        let requestBody: [String: Any] = [
//            "documents": documents,
//            "query": query
//        ]
//
//        guard let requestData = try? JSONSerialization.data(withJSONObject: requestBody) else {
//            return []
//        }
//
//        let headers = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(openAIKey)"
//        ]
//
//        let url = URL(string: "\(openAIEndpoint)/v1/engines/davinci-codex/completions")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = requestData
//
//        let semaphore = DispatchSemaphore(value: 0)
//
//        var searchResults: [SearchResult] = []
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            defer {
//                semaphore.signal()
//            }
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                if let choices = json?["choices"] as? [[String: Any]] {
//                    for choice in choices {
//                        if let document = choice["document"] as? String,
//                           let score = choice["score"] as? Double {
//                            let searchResult = SearchResult(document: document, score: score)
//                            searchResults.append(searchResult)
//                            print("searchResult \(searchResult)")
//                        }
//                    }
//                }
//            } catch {
//                return
//            }
//        }.resume()
//
//        semaphore.wait()
//
//        print("searchResults \(searchResults)")
//
//        return searchResults
//    }


//    private func performSemanticSearch(_ queryEmbedding: QueryEmbedding, _ documentEmbeddings: [DocumentEmbedding]) -> [SearchResult] {
//        var searchResults: [SearchResult] = []
//
//        let queryEmbeddings = queryEmbedding.embeddings
//
//        for queryEmbeddingVector in queryEmbeddings {
//            var queryResults: [SearchResult] = []
//
//            for documentEmbedding in documentEmbeddings {
//                let documentEmbeddingVector = documentEmbedding.embeddings[0] // Assuming a single document embedding
//
//                let similarityScore = calculateCosineSimilarity(queryEmbeddingVector, documentEmbeddingVector)
//
//                let searchResult = SearchResult(
//                    document: documentEmbedding.document,
//                    similarity: similarityScore
//                )
//
//
//                queryResults.append(searchResult)
//            }
//
//            // Sort the search results for this query by similarity score in descending order
//            queryResults.sort { $0.similarity > $1.similarity }
//
//            // Add the top search result for this query to the overall search results
//            if let topResult = queryResults.first {
//                searchResults.append(topResult)
//                print("topResult \(topResult)")
//            }
//        }
//
//        // Sort the overall search results by similarity score in descending order
//        searchResults.sort { $0.similarity > $1.similarity }
//
//        print("searchResults \(searchResults)")
//        return searchResults
//    }

//    private func calculateCosineSimilarity(_ vector1: [Double], _ vector2: [Double]) -> Double {
//        guard vector1.count == vector2.count else {
//            return 0.0
//        }
//
//        var dotProduct: Double = 0.0
//        var magnitude1: Double = 0.0
//        var magnitude2: Double = 0.0
//
//        for i in 0..<vector1.count {
//            dotProduct += vector1[i] * vector2[i]
//            magnitude1 += vector1[i] * vector1[i]
//            magnitude2 += vector2[i] * vector2[i]
//        }
//
//        let magnitudeProduct = sqrt(magnitude1) * sqrt(magnitude2)
//
//        guard magnitudeProduct != 0.0 else {
//            return 0.0
//        }
//
//        print("dotProduct / magnitudeProduct \(dotProduct / magnitudeProduct)")
//
//        return dotProduct / magnitudeProduct
//    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
            .environmentObject(SwiftUISpeech())
            .environmentObject(AudioRecorder())
            .environmentObject(AppState())
    }
}

struct DocumentEmbedding {
    let document: String
    let embeddings: [[Double]]
}

struct QueryEmbedding {
    let query: String
    let embeddings: [[Double]]
}

//struct SearchResult: Identifiable {
//    let id = UUID()
//    let title: String
//    let description: String
//}

struct SearchResult {
    let document: String
    let similarity: Double
}

//struct SearchResult {
//    let document: String
//    let score: Double
//}
