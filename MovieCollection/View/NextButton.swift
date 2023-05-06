//
//  NextButton.swift
//  MovieCollection
//
//  Created by NakaokaRei on 2023/05/06.
//

import SwiftUI

struct NextButton: View {

    let selectedNumber: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Next (Selected: \(selectedNumber))")
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

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(selectedNumber: 5, action: {})
    }
}
