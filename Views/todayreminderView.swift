//
//  todayreminderView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI
struct TodayReminderView: View {
    @ObservedObject var viewModel: PlantViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.plants) { plant in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(plant.name)
                                .font(.headline)
                            Text(plant.wateringDays)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.toggleWatered(for: plant)
                        }) {
                            Image(systemName: plant.isWateredToday ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }
                    }
                }
                .onDelete(perform: viewModel.deletePlant)
            }
            .navigationTitle("Today’s Reminders 🌿")
        }
    }
}

