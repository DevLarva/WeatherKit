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
        let query = ChatQuery(model: .gpt4, messages: [
            Chat(role: .system, content: "Please be sure to give recommendation answer in one word using Korean, only from each given list.And please print them out as 술 + 안주 and Give me random answers every time you ask me questions"),
            Chat(role: .user, content: prompt),
            Chat(role: .assistant, content: "카스 오뎅탕"),
            Chat(role: .user, content: prompt),
            Chat(role: .assistant, content: "카스 오뎅탕"),
            Chat(role: .user, content: prompt)
        ])
        do {
            let result = try await openAI?.chats(query: query)
            respond = result?.choices.first?.message.content ?? ""
        } catch {
            print("AI error: \(error)")
        }
    }
    private func parseAndSetResponse(_ response: String) {
        let components = response.components(separatedBy: " ")
        guard components.count == 4 else {
            print("Invalid response format")
            return
        }
        
        let drink = components[1]
        let dish = components[3]
        
        respond = "술: \(drink) + 안주: \(dish)"
    }
    
}
