//
//  Activity.swift
//  HabiT
//
//  Created by Hari's Mac on 19.03.2025.
//

import SwiftUI
import Observation

struct Activity: Identifiable,Codable,Equatable {
    var id = UUID()
    var name: String
    let date: Date
    var duration: Int
}


class ActivityManager: ObservableObject {

    @Published var activities: [Activity] = []
    private let key = "activities"
    init(){
        loadActivities()
       }
    func saveActivities() {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    func loadActivities() {
            if let savedData = UserDefaults.standard.data(forKey: key),
               let decoded = try? JSONDecoder().decode([Activity].self, from: savedData) {
                activities = decoded
            }
        }
    func addActivity(_ activity: Activity) {
           activities.append(activity)
           saveActivities() // Ensure new activities are saved
       }
}

