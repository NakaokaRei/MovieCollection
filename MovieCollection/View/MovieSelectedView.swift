//
//  MovieSelectedView.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import SwiftUI

struct MovieSelectedView: View {

    @Environment(\.displayScale) var displayScale
    @Binding var selectedImages: Set<URL>

    var body: some View {
        VStack {
            collectionView
            saveButton
        }

    }
}

extension MovieSelectedView {

    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                ForEach(Array(selectedImages), id: \.self) { url in
                    MovieCell(url: url)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }

    var saveButton: some View {
        Button(action: save) {
            Text("Save")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.title2)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
        }
    }

    func collectionView(images: [RenderImage]) -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(images, id: \.id) { renderImage in
                renderImage.image.resizable().scaledToFit()
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    struct RenderImage: Identifiable {
        let id = UUID()
        let image: Image
    }

    func render() async throws -> some View {
        var images: [RenderImage] = []
        for selectedImageURL in selectedImages {
            let (data, _) = try await URLSession.shared.data(from: selectedImageURL)
            if let uiImage = UIImage(data: data) {
                images.append(.init(image: Image(uiImage: uiImage)))
            }
        }
        return collectionView(images: images)
    }

    @MainActor
    func save() {
        Task {
            let renderView = try await render()
            let renderer = ImageRenderer(content: renderView)
            renderer.scale = displayScale

            if let image = renderer.uiImage {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}
