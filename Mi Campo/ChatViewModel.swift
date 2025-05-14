//
//  ChatViewModel.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//


import Foundation
import Alamofire

struct PromptRequest: Encodable {
    let prompt: String
}

struct ResponseData: Decodable {
    let respuesta: String
}

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []

    func sendPrompt(_ prompt: String) {
        let url = "https://a9eb-148-202-101-48.ngrok-free.app/responder"
        let parameters = PromptRequest(prompt: prompt)

        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.messages.append("Tú: \(prompt)")
                    self.messages.append("Bot: \(data.respuesta)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.messages.append("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
