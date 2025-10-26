//
//  todayreminderView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI

struct TodayReminderView: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var showWellDone = false

    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Title
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .padding(.horizontal)
                    
                    // MARK: - Progress / Status Section
                    VStack(alignment: .leading, spacing: 6) {
                        Text(progressText)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        GeometryReader { geo in
                            let total = CGFloat(viewModel.plants.count)
                            let watered = CGFloat(viewModel.plants.filter { $0.isWateredToday }.count)
                            let ratio = total == 0 ? 0 : (watered / total)
                            let filledWidth = ratio * geo.size.width
                            
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(height: 6)
                                
                                Capsule()
                                    .fill(Color.green)
                                    .frame(width: filledWidth, height: 6)
                            }
                        }
                        .frame(height: 6)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    // MARK: - Plants List (swipe to delete)
                    List {
                        ForEach(viewModel.plants) { plant in
                            PlantCardView(plant: plant, viewModel: viewModel)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewModel.deletePlant(plant)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                if showWellDone {
                    Text("🌿 Well done! All your plants feel loved 💚")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(12)
                        .transition(.scale)
                        .padding(.bottom, 80)
                }

                
                // MARK: - Add Button
                Button {
                    viewModel.showReminderSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(
                            LinearGradient(colors: [
                                Color(red: 0.25, green: 0.75, blue: 0.45),
                                Color(red: 0.15, green: 0.55, blue: 0.30)
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(Circle())
                        .shadow(color: .green.opacity(0.4), radius: 8, y: 4)
                        .padding()
                }
                .sheet(isPresented: $viewModel.showReminderSheet) {
                    SetReminderView(viewModel: viewModel)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showAllDone) {
            AllDoneView()
        }
    }
    
    // MARK: - Computed progress text
    private var progressText: String {
        let total = viewModel.plants.count
        let watered = viewModel.plants.filter { $0.isWateredToday }.count
        
        if total == 0 {
            return "No plants added yet 🌱"
        } else if watered == 0 {
            return "Your plants are waiting for a sip 💧"
        } else if watered == total {
            return "All your plants feel loved today ✨"
        } else {
            return "\(watered) of your plants feel loved today ✨"
        }
    }
}

// MARK: - Plant Card View
struct PlantCardView: View {
    var plant: Plant
    @ObservedObject var viewModel: PlantViewModel
    @State private var showWellDone = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Checkmark button
            Button {
                viewModel.toggleWatered(for: plant)
                
                // After updating, check if all plants are watered
                if viewModel.allPlantsWatered {
                    withAnimation {
                        viewModel.showAllDone = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            viewModel.showAllDone = false
                        }
                    }
                }
            } label: {
                Image(systemName: plant.isWateredToday ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(plant.isWateredToday ? .green : .gray)
                    .font(.system(size: 22))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("in \(plant.room)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(plant.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 10) {
                    Label(plant.lightType, systemImage: "sun.max.fill")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    
                    Label(plant.waterAmount, systemImage: "drop.fill")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.07))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.08))
        )
    }
}

#Preview {
    TodayReminderView(viewModel: PlantViewModel())
        .preferredColorScheme(.dark)
}
