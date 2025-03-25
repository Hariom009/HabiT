//
//  ContentView.swift
//  HabiT
//
//  Created by Hari's Mac on 19.03.2025.
//

import SwiftUI

struct ContentView: View {
    
   
    @State private var showEnterName:Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.teal
                VStack{
                    Spacer()
                        .frame(height: 290)
                    Text("Welcome to the Habit Tracker")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    Text("Let's get started")
                        .font(.caption)
                        .padding()
                        .foregroundColor(.secondary)
                    Spacer()
                        .frame(height: 280)
                    NavigationLink("Continue"){
                        EnterNameView()
                    }
                    .padding(.vertical,16)
                    .frame(maxWidth:380,minHeight: 50)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(13)
                    .font(.title3)
                    .sensoryFeedback(.increase, trigger:showEnterName)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("HabiT")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    ContentView()
}
