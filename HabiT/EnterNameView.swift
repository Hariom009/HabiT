//
//  EnterNameView.swift
//  HabiT
//
//  Created by Hari's Mac on 21.03.2025.
//

import SwiftUI

struct EnterNameView: View {
    @State private var personname: String = ""
    @State private var movetoHabit: Bool = false
    @State private var text = "We are what we repeatedly do. Excellence, then, is not an act, but a habit."
    @State private var description = "– Aristotle"
    @State private var t2 = "First we make our habits, then our habits make us."
    @State private var d2 = "– John Dryden"
    var body: some View {
        ZStack{
            Color.clear
            VStack{
                CardView(text: $text, description: $description)
                    .padding()
                CardView(text: $t2, description: $d2)
                    .padding()
                AnimateTextView()
                Spacer()
                FooterView
            }
        }
                       .padding()
                       .background(.ultraThinMaterial)
                       .cornerRadius(15)
                    //   .shadow(radius: 10)
                       .padding()
    }
    private var FooterView:some View{
        VStack{
            HStack{
                Text("Let's Start with your name")
                    .foregroundStyle(Color.gray.opacity(0.5))
                Spacer()
            }
            TextField("Jonathan Adams", text: $personname)
                .padding()
                .frame(maxWidth: 380,minHeight:50)
                .foregroundStyle(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black,lineWidth: 1)
                )
            
               // .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
            Divider()
            NavigationLink("Start"){
                HabitListView()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: 380,minHeight: 50)
            .background(.green)
            .foregroundStyle(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    EnterNameView()
}
