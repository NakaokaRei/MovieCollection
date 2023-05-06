//
//  MovieSearchView.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/05.
//

import SwiftUI

struct MovieSearchView: View {

    @StateObject private var viewModel = MovieSearchViewModel()
    @State private var searchText = ""
    @State private var isPresented = false

    var body: some View {
        NavigationStack {
            MovieSearchResultView(
                moviePosterURLs: $viewModel.moviePosterURLs,
                selectedImages: $viewModel.selectedImages
            )
            .navigationDestination(isPresented: $isPresented) {
                MovieSelectedView(selectedImages: $viewModel.selectedImages)
            }
            .padding()
            .navigationTitle("Movie Collection")
        }
        .searchable(text: $searchText, prompt: Text("Movie Name"))
        .overlay(alignment: .bottom) {
            if !isPresented {
                FloatingButton(selectedNumber: viewModel.selectedImages.count) {
                    isPresented = true
                }
            }
        }
        .onSubmit(of: .search) {
            Task {
                try await viewModel.searchMovie(query: searchText)
            }
        }
    }
}
