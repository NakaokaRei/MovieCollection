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
        VStack(alignment: .leading) {
            Text("Selected")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(selectedImages), id: \.self) { url in
                        MovieCell(url: url)
                            .frame(maxWidth: 40)
                            .cornerRadius(8)
                    }

                }
            }
        }
    }
}
