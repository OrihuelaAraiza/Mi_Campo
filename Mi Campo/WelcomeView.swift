//
//  WelcomeView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @AppStorage("userRole") var userRole: String = ""
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userPhone") var userPhone: String = ""

    @State private var name = ""
    @State private var phone = ""
    @State private var role = "Comerciante"
    @State private var navigate = false

    @State private var locationManagerID = UUID() // 👈 esto reinicia el objeto
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Image("splashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Text("¡Bienvenido a Mi Campo!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextBlack"))
            }
            .padding(.top)

            CustomInputField(icon: "🧑‍🌾", placeholder: "Nombre", text: $name)
            CustomInputField(icon: "📞", placeholder: "Teléfono", text: $phone, isPhone: true)

            Button(action: {
                locationManager.requestPermission()
            }) {
                HStack {
                    Image(systemName: locationManager.permissionGranted ? "checkmark.circle.fill" : "location.fill")
                    Text(locationManager.permissionGranted ? "Ubicación activada" : "Permitir ubicación")
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(locationManager.permissionGranted ? Color("LightGreen") : Color("PrimaryGreen"))
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)

            Text("¿Qué eres?")
                .font(.headline)
                .foregroundColor(Color("TextBlack"))

            Picker("", selection: $role) {
                Text("Comerciante").tag("Comerciante")
                Text("Productor").tag("Productor")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Button(action: {
                hasLaunchedBefore = true
                userRole = role
                userName = name
                userPhone = phone
                navigate = true
            }) {
                Text("Comenzar")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .disabled(!locationManager.permissionGranted)

            Spacer()
        }
        .padding(.top, 24)
        .background(Color("YellowBackground").ignoresSafeArea())
        .fullScreenCover(isPresented: $navigate) {
            MainTabView()
        }
        .id(locationManagerID) 
    }
}
struct CustomInputField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isPhone: Bool = false

    var body: some View {
        HStack {
            Text(icon)
                .font(.title2)
            TextField(placeholder, text: $text)
                .keyboardType(isPhone ? .phonePad : .default)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
