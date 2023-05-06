//
//  MovieCell.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/05.
//

import SwiftUI

struct MovieCell: View {

    let url: URL

    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(
            url: URL(string: "https://image.tmdb.org/t/p/w500/6KErczPBROQty7QoIsaa6wJYXZi.jpg")!
        )
    }
}
