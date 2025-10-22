//
//  ContentView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI
struct ContentView: View {
    var body: some View{
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 20){
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 50)
                Image("P2")
            }
        }
    }
    
    
    
    
    
}
