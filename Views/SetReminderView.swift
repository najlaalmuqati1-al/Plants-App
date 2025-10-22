//
//  SetReminderView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PlantViewModel
    
    @State private var name = ""
    @State private var room = "Living Room"
    @State private var wateringDays = "Every 3 days"
    @State private var waterAmount = "100-200 ml"
    @State private var lightType = "Partial Sun"
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let wateringOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]
    
    var body: some View {
        NavigationView {
            Form {
                HStack{
                    Text("Plant name")
                    TextField("Photo", text: $name)
                }
                
                Section{
                    Picker("Room", selection: $room) {
                        ForEach(rooms, id: \.self) { room in
                            Text(room)
                        }
                    }
                    
                    Picker("Light", selection: $lightType) {
                        ForEach(lightOptions, id: \.self) { light in
                            Text(light)
                        }
                    }
                }
                
                Section{
                    Picker("Watering Days", selection: $wateringDays) {
                        ForEach(wateringOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    
                    Picker("Water", selection: $waterAmount) {
                        ForEach(waterAmounts, id: \.self) { amount in
                            Text(amount)
                        }
                    }
                }
                
                
                
            }
        }
    }
}
        

    

