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
    var body: some View {
        NavigationStack{
            Form {
                TextField("Habit Name", text: $habitName)
                DatePicker("Select Date",selection: $date,displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle()) // Enables calendar view
                .padding()
                Text("")
                TextField("Duration", value: $time, format:.number)
               
            }
            .navigationTitle("Add new Habit")
            .toolbar{
                Button("Done"){
                    let newactivity = Activity(name: habitName, date: date, duration: time)
                    activitymanager.addActivity(newactivity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditNewHabit(activitymanager: ActivityManager())
}
