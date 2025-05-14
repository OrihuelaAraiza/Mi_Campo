//
//  ChatView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userInput: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(viewModel.messages.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message.starts(with: "Tú:") {
                                    Spacer()
                                    Text(message.replacingOccurrences(of: "Tú: ", with: ""))
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                } else if message.starts(with: "Bot:") {
                                    Text(message.replacingOccurrences(of: "Bot: ", with: ""))
                                        .padding()
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(10)
                                    Spacer()
                                } else {
                                    Text(message)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }

            Divider()

            HStack {
                TextField("Escribe tu mensaje...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Enviar") {
                    let prompt = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !prompt.isEmpty else { return }
                    viewModel.sendPrompt(prompt)
                    userInput = ""
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Asistente Agrícola 🤖")
    }
}
