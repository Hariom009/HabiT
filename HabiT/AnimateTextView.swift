//
//  AnimateTextView.swift
//  HabiT
//
//  Created by Hari's Mac on 22.03.2025.
//

import SwiftUI

struct AnimateTextView: View {
    @State private var animate = false

       var body: some View {
            Text("Let's boost the productivity and start this embracing Journey with us!")
                       .font(.headline)
                       .fontWeight(.bold)
                       .padding()
               .scaleEffect(animate ? 1.2 : 1.0)
               .animation(
                   Animation.easeInOut(duration: 0.8)
                       .repeatForever(autoreverses: true),
                   value: animate
               )
               .onAppear {
                   animate = true
               }
       }
}

#Preview {
    AnimateTextView()
}
