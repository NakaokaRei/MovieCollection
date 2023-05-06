//
//  APIClient.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import Foundation

final class APIClient {

    let apiKey = ""

    func fetchMoviePosterURL(movieName: String) async throws -> [URL] {
        let encodedMovieName = movieName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedMovieName)&language=jp&region=jp")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
        let movies = response.results
        let urls = movies.compactMap { $0.posterPath }
        return urls.map { URL(string: "https://image.tmdb.org/t/p/w500/\($0)")! }
    }
}
