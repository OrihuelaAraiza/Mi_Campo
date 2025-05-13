//
//  SplashScreenView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//
import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State private var scale: CGFloat = 0.6

    var body: some View {
        ZStack {
            Color("YellowBackground").ignoresSafeArea()

            VStack {
                Image("splashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.5)) {
                            scale = 1.0
                        }
                    }

                Text("Mi Campo")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("TextBlack"))
                    .padding(.top, 12)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isActive = false
            }
        }
    }
}
