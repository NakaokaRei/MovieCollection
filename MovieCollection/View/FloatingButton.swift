//
//  FloatingButton.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import SwiftUI

struct FloatingButton: View {

    let selectedNumber: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Create Image (Selected: \(selectedNumber))")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundColor(.white)
                .background(selectedNumber >= 9 ? Color.blue: Color.gray)
                .cornerRadius(10)
        }
        .disabled(selectedNumber < 9)
        .padding()
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(selectedNumber: 5, action: {})
    }
}
