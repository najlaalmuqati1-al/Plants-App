//
//  File.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import Foundation
import Combine
import SwiftUI
class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var showReminderSheet = false
    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
    }
    
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWateredToday.toggle()
        }
    }
    
    func deletePlant(at indexSet: IndexSet) {
        plants.remove(atOffsets: indexSet)
    }
}


