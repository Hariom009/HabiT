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
    @State private var takeToaQuill = false
    
    
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
                                   .frame(width: 50, height: 65)
                                   .background(isSameDay(date: i))
                                   .foregroundColor(.white)
                                   .clipShape(RoundedRectangle(cornerRadius: 15))
                                   .background(i == .now ? Color.green: Color.clear)
                           }
                       }
                    .padding()
            }
                .scrollIndicators(.hidden)
     List {
         ForEach(activityManager.activities, id: \.id) { activity in
             NavigationLink(destination: HabitViewWDescirption( activity: activity)){
                 HStack {
                     if(activity.name == "Meditate" || activity.name == "meditation" || activity.name == "Meditation"){
                         Text("🧘‍♀️")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "study" || activity.name == "Study"){
                         Text("📖")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "play" || activity.name == "Play"){
                         Text("🤾🏻‍♂️")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "Devolopment" || activity.name == "development"){
                         Text("🧑‍💻")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "Drink" || activity.name == "drink"){
                         Text("💧")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "bicycle" || activity.name == "Bicycle"){
                         Text("🚴")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     if(activity.name == "Read" || activity.name == "read"){
                         Text("🧑‍🏫")
                             .font(.largeTitle)
                             .fontWeight(.bold)
                             .padding()
                     }
                     VStack(alignment: .leading) {
                         HStack{
                             Text(activity.name)
                                 .font(.title2)
                                 .fontWeight(.semibold)
                             if activity.isCompletedToday  {
                                 Image(systemName: "checkmark.circle.fill")
                                     .foregroundColor(.green)
                             }
                         }
                         Text("Date Added: \(activity.date.formatted(date: .abbreviated, time: .omitted))")
                             .font(.caption)
                         
                     }
                 }
             }
             .padding()
             .buttonStyle(.borderless)
             // Best solution i ever got to get rid of reset the random color element each time that disco effect
             .background(activity.color.opacity(0.2))
             
             .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    // Here the streak is getting plus
//                    .onTapGesture {
//                        plusActivity(activityid: activity.id)
//                    }
         //Here i put a borderless button style
              //  .buttonStyle(.plain)
                .onDelete(perform: removeItems) // Attach onDelete to List
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Today's List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                       Spacer() // pushes button to center
                   }
                // This is the home button just in case if one wants to see the home button
//                ToolbarItem(placement: .navigationBarTrailing) {
//               NavigationLink(destination: ContentView()) {
//                   Image(systemName:"house.fill")
//                       .foregroundColor(.black)
//                    }
//                }
                
                ToolbarItem(placement:.bottomBar){
                    Button{
                        takeToaQuill = true
                    }label:{
                        Image(systemName: "circle.hexagongrid.circle")
                            .font(.title)
                    }
                }
                ToolbarItem(placement:.bottomBar){
                    Button{
                        showEditHabit =  true
                    }label:{
                        Image(systemName: "plus.rectangle.fill")
                            .font(.custom("", fixedSize: 49))
                                .foregroundColor(.blue)
                                .fontWeight(.thin)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                    .foregroundColor(.black)
                }

                ToolbarItem(placement: .bottomBar) {
                       Spacer() // pushes button to center
                   }
            }
            .sheet(isPresented: $showEditHabit){
                EditNewHabit(activitymanager: activityManager)
            }
            .sheet(isPresented: $takeToaQuill){
                ChatWithGeminiView()
            }
        }
        .onAppear {
            activityManager.loadActivities()
        }
    }

    
  //  Here is the function for streak add
    
//    func plusActivity(activityid: UUID) {
//        if let index = activityManager.activities.firstIndex(where: { $0.id == activityid }) {
//            let lastUpdated = activityManager.activities[index].lastUpdated
//            if !Calendar.current.isDateInToday(lastUpdated) {
//                activityManager.activities[index].duration += 1
//                activityManager.activities[index].lastUpdated = Date()
//            }
//        }
//    }
//    
    
    
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
    
      private func isSameDay(date: Date) -> Color {
     let tempdate = Date()
          let Formatter = DateFormatter()
          Formatter.dateFormat = "MM dd yyyy"
          let currentDateString = Formatter.string(from: tempdate)
          let dateString = Formatter.string(from: date)
          
          if currentDateString == dateString {
              return .black
          }else if (dateString < currentDateString){
              return .green
          }
          else {
              return .gray
          }
      }
    
    
    
    func removeItems(at offsets: IndexSet) {
        activityManager.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    HabitListView()
}
