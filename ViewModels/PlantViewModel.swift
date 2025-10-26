//
//  File.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import Foundation
import Combine
import SwiftUI
import UserNotifications

class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var showReminderSheet = false
    @Published var navigateToReminders = false
    @Published var showAllDone = false
    @Published var selectedPlant: Plant? = nil
    @Published var isEditingPlant = false

    

    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        sendLocalNotification()
    }
    
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWateredToday.toggle()
        }
        if plants.allSatisfy({ $0.isWateredToday }) && !plants.isEmpty {
                showAllDone = true
            }
        
    }
    
    func deletePlant(at indexSet: IndexSet) {
        plants.remove(atOffsets: indexSet)
   
    }
    func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
    func scheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Time to water \(plant.name)"
        content.body = "Don’t forget to give your \(plant.name) some love 💧"
        content.sound = .default

        // مثلًا كل 24 ساعة
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)

        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("⏰ Notification scheduled for \(plant.name)")
            }
        }
    }
    func ScheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Time to water \(plant.name)"
        content.body = "Don’t forget to give your \(plant.name) some love 💧"
        content.sound = .default

        // مثلًا كل 24 ساعة
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)

        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("⏰ Notification scheduled for \(plant.name)")
            }
        }
    }
    var allPlantsWatered: Bool {
        !plants.isEmpty && plants.allSatisfy { $0.isWateredToday }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
        }
    }
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! Let’s water your plant"
        content.sound = .default

        // بعد 5 ثواني (بس للتجربة)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled successfully")
            }
        }
    }

}



