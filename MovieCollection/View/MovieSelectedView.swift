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
            shareToInstagramStoryButton
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

    var shareToInstagramStoryButton: some View {
        Button(action: { Task { try await shareToInstagramStory() } }) {
            Text("Share to Instagram Story")
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

    @MainActor
    func shareToInstagramStory() async throws {
        let renderView = try await render()
        let renderer = ImageRenderer(content: renderView)
        renderer.scale = displayScale

        if let image = renderer.uiImage {
            let pasteboardItems = [
                ["com.instagram.sharedSticker.backgroundImage": image.pngData()!] as [String : Any],
                ["com.instagram.sharedSticker.backgroundTopColor": "#ff5a60"],
                ["com.instagram.sharedSticker.backgroundBottomColor": "#ff5a60"]
            ]
            UIPasteboard.general.setItems(pasteboardItems)
            await UIApplication.shared.open(URL(string: "instagram-stories://share")!)
        }
    }
}
