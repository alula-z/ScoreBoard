//
//  SwiftUIView.swift
//  MyScoreBoard
//
//  Created by Alula Zeruesenay on 9/20/25.
//

import SwiftUI

struct gameConfirm: View {
    var teamA:String
    var teamB: String
    var scoreA: Int
    var scoreB : Int
    var result : String
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 25){
            Text("Game Saved")
                .font(.title2)
                .padding(5)
                .fontWeight(.bold)
                .overlay(Rectangle()
                    .frame(height:2)
                    .offset(y:3)
                         ,alignment: .bottom)
            
            VStack(spacing: 10){
                Text("\(teamA)   vs   \(teamB)")
                    .font(.headline)
                
                Text("\(scoreA) - \(scoreB)")
                    .font(.headline)
                
                Text(result)
                    .font(.headline)
            }
            
                Text("Navigate to History to see all saved games")
                    .font(.caption)
                            
                
            Button(action: {onConfirm()}, label: {
                Text("OK")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .fontWeight(.bold)
            })
                .padding()
                .background(Color.brandSecondary)
                .clipShape(.capsule)
                
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(radius:15)
        .padding(40)
        .foregroundStyle(.black)
    }
}

#Preview {
    gameConfirm( teamA: "Team A", teamB: "Team B", scoreA: 10, scoreB: 20,result: "Winner is Team B", onConfirm: {print("ok")})
}
