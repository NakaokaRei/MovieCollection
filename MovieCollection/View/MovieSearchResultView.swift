//
//  MovieSearchResultView.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import SwiftUI

struct MovieSearchResultView: View {

    @Binding var moviePosterURLs: [URL]
    @Binding var selectedImages: Set<URL>

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(moviePosterURLs, id: \.self) { url in
                        MovieCell(url: url)
                            .overlay(selectedImages.contains(url) ? Color.white.opacity(0.8) : Color.clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                if selectedImages.contains(url) {
                                    selectedImages.remove(url)
                                } else if selectedImages.count < 9 {
                                    selectedImages.insert(url)
                                }
                            }
                    }
                }
            }
        }
    }
}
