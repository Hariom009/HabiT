//
//  EditNewHabit.swift
//  HabiT
//
//  Created by Hari's Mac on 19.03.2025.
//

import SwiftUI

struct EditNewHabit: View {
    @Environment(\.dismiss) var dismiss
    @State var habitName: String = ""
    @State var time: Int = 0
    @State var date: Date = Date()
    var activitymanager: ActivityManager
    
    var isValid: Bool{
        !habitName.isEmpty
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color.green.opacity(0.7)
                    .ignoresSafeArea()
                Color.yellow.opacity(0.2)// or any custom color
                    .ignoresSafeArea()
                Image("Meditate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 250)
                    .padding(.bottom,12)
                Form {
                    TextField("Habit Name", text: $habitName)
                        .padding(6)
                        .listRowBackground(Color.white.opacity(0.5))
                    DatePicker("Date",selection: $date,displayedComponents: [.date])
                        .padding(8)
                        .listRowBackground(Color.white.opacity(0.5))
                    // Things i got to do here
                    /*
                     1. Put a timer
                     2. Put a 4-5 lofi so that i can play any randomly
                     3. Edit the EditHabitView
                     4.
                     */
                }
                .scrollContentBackground(.hidden)
                
                
                
                
                VStack(spacing: 12){
                  
                      //  .padding(.top,150)
                    Spacer()
                VStack(alignment: .leading,spacing: 12){
                    HStack{
                        Image(systemName: "music.note.list")
                        Text("Calm music can help you")
                    }
                    .padding()
                    .background(
                        Color.white.opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                    )
                    
                    HStack{
                        Image(systemName: "drop")
                        Text("Water is important")
                    }
                    .padding()
                    .background(
                        Color.white.opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                    )
                    HStack{
                        Image(systemName: "drop")
                        Text("Mindful Breathing helps you relax")
                    }
                    .padding()
                    .background(
                        Color.white.opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                    )
                }
                 Button("Finish"){
                     let newactivity = Activity(name: habitName, date: date, duration: time)
                     activitymanager.addActivity(newactivity)
                    dismiss()
                }
                .frame(maxWidth: 320,minHeight: 55)
                .background(.white)
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .cornerRadius(20)
                .padding(.top,20)
              }
            }
            .navigationTitle("Add new Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button{
                    let newactivity = Activity(name: habitName, date: date, duration: time)
                    activitymanager.addActivity(newactivity)
                    dismiss()
                }label: {
                    Image(systemName: "xmark")
                }
                .disabled(!isValid)
            }
        }
    }
}

#Preview {
    EditNewHabit(activitymanager: ActivityManager())
}
