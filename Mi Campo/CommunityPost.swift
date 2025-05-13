//
//  CommunityPost.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct CommunityPost: View {
    var user: String
    var avatar: String
    var content: String

    @State private var isPressed = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(avatar)
                .font(.system(size: 44))
                .scaleEffect(isPressed ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)

            VStack(alignment: .leading, spacing: 6) {
                Text(user)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryGreen"))

                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(nil)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.95))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .onTapGesture {
            withAnimation {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    isPressed = false
                }
            }
        }
        .padding(.horizontal)
    }
}
