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
       EnterNameView()
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
