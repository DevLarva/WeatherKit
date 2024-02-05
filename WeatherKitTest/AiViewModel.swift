//
//  AiViewModel.swift
//  WeatherKitTest
//
//  Created by 백대홍 on 2/5/24.
//

import Foundation
import SwiftUI
import OpenAI


struct AiModel: Decodable {
    let openai: String
}


@Observable class AiViewModel {
    var openAI: OpenAI?
    var respond = ""
    
    init() {
        guard let url = Bundle.main.url(forResource: "SecureAPIKEYS", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let keys = try PropertyListDecoder().decode(AiModel.self, from: data)
            openAI = OpenAI(apiToken: keys.openai)
        } catch {
            //"Decoding error: \(error)".debug()
            print("Decoding error")
        }
    }

    func request(prompt: String) async {
        let query = ChatQuery(model: .gpt3_5Turbo_16k, messages: [
            Chat(role: .system, content: "Please be sure to give recommendation answer in one word using Korean, only from each given list."),
            Chat(role: .user, content: prompt)
        ])
        
        do {
            let result = try await openAI?.chats(query: query)
            respond = result?.choices.first?.message.content ?? ""
        } catch {
            print("AI error: \(error)")
        }
    }
}
