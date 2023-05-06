//
//  MovieSearchViewModel.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import Foundation

@MainActor
class MovieSearchViewModel: ObservableObject {

    @Published var moviePosterURLs: [URL] = []

    let apiClient = APIClient()

    func searchMovie(query: String) async throws {
        moviePosterURLs = try await apiClient.fetchMoviePosterURL(movieName: query)
    }
}
