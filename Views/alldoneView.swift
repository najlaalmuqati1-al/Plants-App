//
//  alldoneView.swift
//  Plants App
//
//  Created by Najla Almuqati on 27/04/1447 AH.
//

import SwiftUI

struct AllDoneView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                    Spacer()
                }

                .padding(.horizontal, 10)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, 16)
            }
            .padding(.top, -330)

            Spacer().frame(height: 40)
            
                VStack(spacing: 30) {
                    Image("P22") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(radius: 10)
                    
                    Text("All Done! 🎉")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
    
                    Text("All Reminders Completed")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
               // Button {
                    // لو تبين يرجع لصفحة البداية
              //  } label: {
                 //   Text("Back to My Plants")
                   //     .font(.headline)
                    //    .foregroundColor(.white)
                     //   .frame(width: 260, height: 50)
                     //   .background(Color.green.opacity(0.7))
                      //  .cornerRadius(25)
               // }
               // .padding(.bottom, 50)
            }
            .padding(.horizontal)
        }
    }


#Preview {
    AllDoneView()
        .preferredColorScheme(.dark)
}

