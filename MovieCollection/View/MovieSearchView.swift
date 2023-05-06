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

    var body: some View {
        NavigationView {
            MovieSearchResultView(
                moviePosterURLs: $viewModel.moviePosterURLs,
                selectedImages: $viewModel.selectedImages
            )
            .padding()
            .navigationTitle("Movie Collection")
        }
        .searchable(text: $searchText, prompt: Text("Movie Name"))
        .overlay(alignment: .bottom) {
            NextButton(selectedNumber: viewModel.selectedImages.count) {
                //
            }
        }
        .onSubmit(of: .search) {
            Task {
                try await viewModel.searchMovie(query: searchText)
            }
        }
    }
}
