//
//  plant.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import Foundation
struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var wateringDays: String
    var room: String
    var waterAmount: String
    var lightType: String
    var isWateredToday: Bool = false
    
}

