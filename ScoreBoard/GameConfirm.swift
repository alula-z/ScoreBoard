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
        VStack(spacing: 20){
            Text("Game Saved")
                .font(.headline)
            VStack(spacing: 10){
                Text("\(teamA) vs \(teamB)")
                    .font(.subheadline)
                
                Text("\(scoreA) - \(scoreB)")
                    .font(.subheadline)
                
                Text(result)
                    .font(.subheadline)
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
