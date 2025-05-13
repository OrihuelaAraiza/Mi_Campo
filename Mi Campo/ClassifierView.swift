//
//  ClassifierView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI
import CoreML
import Vision
import UIKit

struct ClassifierView: View {
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @State private var prediction: String = ""
    @State private var confidence: Double = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Text("Clasificador de Hojas")
                .font(.largeTitle.bold())

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay(Text("Selecciona una imagen").foregroundColor(.gray))
            }

            Button(action: {
                showImagePicker = true
            }) {
                Label("Elegir imagen", systemImage: "photo")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            if !prediction.isEmpty {
                Text("Resultado: \(prediction)")
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                Text("Confianza: \(String(format: "%.2f", confidence * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
                .onDisappear {
                    if let img = image {
                        classifyImage(img)
                    }
                }
        }
        .padding()
    }

    func classifyImage(_ uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else { return }

        guard let model = try? VNCoreMLModel(for: PlantDiseaseClassifier().model) else { return }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation], let top = results.first {
                prediction = top.identifier
                confidence = Double(top.confidence)
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage)
        try? handler.perform([request])
    }
}
