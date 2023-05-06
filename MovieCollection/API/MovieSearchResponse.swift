//
//  MovieSearchResponse.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import Foundation

struct MovieSearchResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
