//
//  ChatWithGeminiView.swift
//  HabiT
//
//  Created by Hari's Mac on 08.04.2025.
//

import SwiftUI
import GoogleGenerativeAI

struct ChatWithGeminiView: View {
    let model = GenerativeModel(name: "gemini-1.5-pro", apiKey: APIKey.default)
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "How can I help you today?"
    @State var isLoading = false
    var body: some View {
          
        VStack {
            Text("Welcome to Quill")
                .font(.largeTitle)
                .foregroundStyle(.indigo)
                .fontWeight(.bold)
                .padding(.top, 40)
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title3)
                }
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }
                
            }
            HStack{
                TextField("Ask anything...", text: $userPrompt, axis: .vertical)
                    .lineLimit(5)
                    .font(.title3)
                    .padding()
                    .background(Color.indigo.opacity(0.2), in: Capsule())
                    .disableAutocorrection(true)
                Button{
                    generateResponse()
                }label: {
                    Image(systemName: "paperplane.fill")
                }
            }
        }
        .padding()
    }
    
    func generateResponse(){
        isLoading = true;
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                userPrompt = ""
            } catch {
                response = "Something went wrong! \n\(error.localizedDescription)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ChatWithGeminiView()
    }
}

