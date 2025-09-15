//
//  File.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/13/25.
//

import Foundation
import SwiftUI

struct landingPage: View {
    @State var selectedTab = 0
    @State var showMain = false
    var body: some View{
        if showMain {
            MainView(selectTab: $selectedTab)
        }else{
            ZStack{
                Color("BrandBackground")
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    //Logo
                    Image("AppIconBase")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                    Text("ScoreBoard")
                        .foregroundStyle(.black)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                    Spacer()
                    //Buttons
                    VStack(spacing: 20){
                        //Start new game
                        Button(action: {
                            selectedTab = 0
                            showMain = true
                        }){
                            Text("Start a new game")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .padding(.vertical, 10)
                        .frame(maxWidth: 250)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(15)
                        
                        //View History
                        Button(action: {
                            selectedTab = 1
                            showMain = true
                        }){
                            Text("View History")
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.blue)
                        .padding()
                        .padding(.vertical, 10)
                        .frame(maxWidth: 250)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth:4)
                        )
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    landingPage()
}
