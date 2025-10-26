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
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Text("Set Reminder")
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                
                let newPlant = Plant(
                    name: name,
                    wateringDays: wateringDays,
                    room: room,
                    waterAmount: waterAmount,
                    lightType: lightType
                )
                
                
                viewModel.addPlant(newPlant)
                viewModel.scheduleNotification(for: newPlant)
                viewModel.navigateToReminders = true
                
                dismiss()
                
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(
                        LinearGradient(colors: [
                            Color(red: 0.22, green: 0.65, blue: 0.37),
                            Color(red: 0.12, green: 0.45, blue: 0.25)
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        
        NavigationView {
            Form {
                HStack{
                    Text("Plant name")
                    TextField("Pothos", text: $name)
                }
                Section {
                    HStack {
                        Label("", systemImage: "location")
                            .foregroundColor(.white)
                        Picker("Room", selection: $room) {
                            ForEach(rooms, id: \.self) { room in
                                Text(room)
                            }
                        }
                    }
                    
                    HStack{
                        Label("", systemImage: "sun.max")
                            .foregroundColor(.white)
                        Picker("Light", selection: $lightType) {
                            ForEach(lightOptions, id: \.self) { light in
                                Text(light)
                            }
                        }
                    }
                }
                Section{
                    HStack{
                        Label("", systemImage: "drop")
                            .foregroundColor(.white)
                        Picker("Watering Days", selection: $wateringDays) {
                            ForEach(wateringOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                    }
                        HStack{
                            Label("", systemImage: "drop")
                                .foregroundColor(.white)
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
        
    }
#Preview {
    StartView(viewModel: PlantViewModel())
        .preferredColorScheme(ColorScheme.dark)
}
    

