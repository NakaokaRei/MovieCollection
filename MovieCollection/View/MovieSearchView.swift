//
//  MovieSearchView.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/05.
//

import SwiftUI

struct MovieSearchView: View {

    @StateObject private var viewModel = MovieSearchViewModel()
    @State var searchText = ""
    @State var selectedImages: Set<URL> = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(viewModel.moviePosterURLs, id: \.self) { url in
                        MovieCell(url: url)
                            .overlay(selectedImages.contains(url) ? Color.white.opacity(0.8) : Color.clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                if selectedImages.contains(url) {
                                    selectedImages.remove(url)
                                } else {
                                    selectedImages.insert(url)
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Movie Collection")
        }
        .searchable(text: $searchText, prompt: Text("Movie Name"))
        .onSubmit(of: .search) {
            Task {
                try await viewModel.searchMovie(query: searchText)
            }
        }
    }
}
