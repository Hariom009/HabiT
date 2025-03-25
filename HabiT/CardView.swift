//
//  CardView.swift
//  HabiT
//
//  Created by Hari's Mac on 20.03.2025.
//

import SwiftUI

struct CardView: View {
    @Binding var text: String
    @Binding var description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(text)")
                .font(.headline)
                .foregroundColor(.white)
            Text("\(description)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
        .shadow(radius: 5) // Adds shadow effect
        .padding(.horizontal)
    }
}
#Preview {
    @Previewable @State var sampleText = "Sample Title"
    @Previewable @State var sampleDescription = "This is a description."

    CardView(text: $sampleText, description: $sampleDescription)
}
