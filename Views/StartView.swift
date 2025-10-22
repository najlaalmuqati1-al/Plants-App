//
//  StartView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//
import SwiftUI

struct StartView: View {
    @StateObject var viewModel: PlantViewModel
    init(viewModel: PlantViewModel = PlantViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 50) {
            
            VStack(spacing: 15) {
                HStack {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 70)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, 16)
            }
            
            Spacer().frame(height: 40)
            
            
            VStack(spacing: 30) {
                Image("P2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                
                Text("Start your plant journey!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Now all your plants will be in one place and we will help you take care of them 🪴")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
                
                Button("Set Plant Reminder") {
                    viewModel.showReminderSheet = true
                }
                .frame(width: 300, height: 50)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.35, green: 0.75, blue: 0.60),
                            Color(red: 0.25, green: 0.65, blue: 0.50)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 4, y: 2)
                
                .sheet(isPresented: $viewModel.showReminderSheet) {
                    SetReminderView(viewModel: viewModel)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
    
    #Preview {
        StartView(viewModel: PlantViewModel())
    }
}
