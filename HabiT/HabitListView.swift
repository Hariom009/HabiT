//
//  HabitListView.swift
//  HabiT
//
//  Created by Hari's Mac on 19.03.2025.
//

import SwiftUI

struct HabitListView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showEditHabit = false
    @ObservedObject private var activityManager =  ActivityManager()
    @State private var type: String = ""
    @State private var date = Date()
    
  //  var PersonNAME: String
    private var dateRange:[Date]{
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -2, to: Date())!
        let endDate = calendar.date(byAdding: .day, value: 30, to: Date())!
        return generateDates(from: startDate, to: endDate)
    }
    var body: some View {
        NavigationStack{
            ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 10) {
                           ForEach(dateRange, id: \.self) { i in
                               Text(dateFormatter.string(from: i))
                                   .font(.system(size: 13, weight: .bold))
                                   .frame(width: 60, height: 40)
                                   .background(isSameDay(date1:date, date2: i) ? Color.blue : Color.gray.opacity(0.3))
                                   .foregroundColor(.white)
                                   .clipShape(RoundedRectangle(cornerRadius: 15))
//                                   .onTapGesture {
//                                       date = i
//                                   }
                           }
                       }
                    .padding()
            }
                .scrollIndicators(.hidden)
//            HStack{
//                Text("Welcome \(PersonNAME)")
//                Spacer()
//            }
            List {
                ForEach(activityManager.activities, id: \.id) { activity in
                    HStack {
                        Text("\(activity.name)")
                        Spacer()
                        Text("\(activity.duration)")

                        Button {
                            plusActivity(activityid: activity.id)
                            print("plus")
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .onDelete(perform: removeItems) // Attach onDelete to List
            }
            .scrollContentBackground(.hidden)
            
            .navigationTitle("Habit-list")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Add Habit"){
                    showEditHabit =  true
                }
            }
            .sheet(isPresented: $showEditHabit){
                EditNewHabit(activitymanager: activityManager)
            }
            .toolbar {
                // This is the home button just in case if one wants to see the home button
                ToolbarItem(placement: .bottomBar) {
               NavigationLink(destination: ContentView()) {
                    Text("Home")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
            }
        }
        .onAppear {
            activityManager.loadActivities()
        }
    }
    func plusActivity(activityid:UUID){
        if let index = activityManager.activities.firstIndex(where: {$0.id == activityid}){
            
            var updatedActivity = activityManager.activities[index] // Copy the struct
                   updatedActivity.duration += 1          // Modify the copy
            activityManager.activities[index] = updatedActivity
        }
   }

    
    func generateDates(from startDate:Date, to endDate:Date) -> [Date]{
        var dates:[Date] = []
        var currentDate = startDate
       _ = Calendar.current
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day,value: 1, to: currentDate)!
        }
        return dates
    }
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            return formatter
    }
    
      private func isSameDay(date1: Date, date2: Date) -> Bool {
          let calendar = Calendar.current
          return calendar.isDate(date1, inSameDayAs: date2)
      }
    func removeItems(at offsets: IndexSet) {
        activityManager.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    HabitListView()
}
