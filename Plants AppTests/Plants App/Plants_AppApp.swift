//
//  Plants_AppApp.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI

@main
struct Plants_AppApp: App {
    @StateObject var viewModel = PlantViewModel()
    var body: some Scene {
        WindowGroup {
            StartView(viewModel: viewModel)
        }
    }
}
import UserNotifications

struct PlantApp: App {
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notifications allowed")
            } else {
                print("❌ Notifications denied")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            StartView(viewModel: PlantViewModel())
        }
    }
}
