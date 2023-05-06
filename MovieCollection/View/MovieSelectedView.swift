//
//  MovieSelectedView.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import SwiftUI

struct MovieSelectedView: View {

    @Binding var selectedImages: Set<URL>

    var body: some View {
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
}
