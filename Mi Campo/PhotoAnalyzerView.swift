import SwiftUI
import UIKit

struct PhotoAnalyzerView: View {
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var resultText: String = "Sube o toma una foto de tu cultivo 🌱"
    @State private var showingCamera = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Revisa la salud de tus cultivos")
                .font(.title)
                .bold()

            if let image = inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(16)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(Text("Sin imagen").foregroundColor(.gray))
                    .cornerRadius(16)
            }

            Text(resultText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            HStack {
                Button {
                    showingCamera = true
                    showImagePicker = true
                } label: {
                    Label("Tomar foto", systemImage: "camera.fill")
                }
                .buttonStyle(.borderedProminent)

                Button {
                    showingCamera = false
                    showImagePicker = true
                } label: {
                    Label("Subir imagen", systemImage: "photo.fill")
                }
                .buttonStyle(.bordered)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage, useCamera: showingCamera, onImagePicked: simulateClassification)
        }
        .padding()
    }

    func simulateClassification(_ image: UIImage) {
        inputImage = image

        let resultados = [
            ("Planta sana", "✅ Tu cultivo parece saludable. Sigue con los cuidados habituales 🌱."),
            ("Tizón tardío", "⚠️ Se observan manchas oscuras en hojas y tallos. Aplica fungicida a base de cobre 🧴."),
            ("Mildiu", "⚠️ Hay presencia de polvillo blanco en las hojas. Reduce la humedad y aplica tratamiento 💧."),
            ("Mancha foliar", "⚠️ Se detectan puntos oscuros en las hojas. Retira las partes afectadas y aplica control 🌿."),
            ("Pulgones", "⚠️ Pequeños insectos visibles. Usa jabón potásico o insecticida natural 🐛.")
        ]

        let resultado = resultados.randomElement()!

        resultText = resultado.1
    }
}
