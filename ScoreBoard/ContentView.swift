//
//  ContentView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/1/25.
//

import SwiftUI
import CoreData
import os
struct ContentView: View {
    let logger = Logger(subsystem: "me.zeruesenay.alula.ScoreBoard", category: "Game")
    @Environment(\.managedObjectContext) private var viewContext
    @State var scoreA = 0;
    @State var scoreB = 0;
    @State var teamA = "";
    @State var teamB = "";
    @State var resetAlert = false;
    @State var resetMessage = "";
    @State var plusBool = true;
    @State var gameFinished = false;
    var result : String {
        if scoreA > scoreB {
            return "Winning Team: \(teamA)"
        }else if scoreA < scoreB {
            return "Winning Team: \(teamB)"
        } else {
            return "Draw"
        }
    }
    struct Game{
        var teamA:String
        var teamB:String
        let scoreA:Int
        let scoreB: Int
        let date: Date
    }
    func resetScore(){
        scoreA = 0
        scoreB = 0
        teamA = ""
        teamB = ""
    }
    func saveGame(){
        let entity = GameEntity(context: viewContext)
        entity.teamA = teamA.isEmpty ? "Team A" : teamA
        entity.teamB = teamB.isEmpty ? "Team B" : teamB
        entity.scoreA = Int32(scoreA)
        entity.scoreB = Int32(scoreB)
        entity.date = Date.now
        do{
            try viewContext.save()
            gameFinished = true
        }catch{
            logger.error("Failed to save game: \(error.localizedDescription)")
        }
    }
    var body: some View {
        ZStack{
            Color("BrandBackground")
                .ignoresSafeArea()
            VStack{
                Text("ScoreBoard")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .frame(alignment: .top)
                    .foregroundStyle(.black)
                Spacer()
                
                VStack(spacing: 20){
                    HStack(spacing: 10){
                        VStack(spacing: 20){
                            TextField(text: $teamA, label: { Text("Team A...") })
                                .font(.title2)
                                .padding(.vertical, 5)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.brandSecondary)
                                .background(Color.brandBackground)
                                .cornerRadius(10)
                            
                            Text("\(String(scoreA))")
                                .frame(width: 120,height: 150)
                                .padding()
                                .padding(.vertical, 10)
                                .font(.system(size: 60))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth:2)
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.white.opacity(0.2))
                                )
                                .foregroundStyle(Color.orange)
                        }
                        Spacer()
                        VStack(spacing: 20){
                            TextField(text: $teamB, label: {
                                Text("Team B...")
                            })
                            .font(.title2)
                            .padding(.vertical, 5)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .foregroundStyle(Color.brandSecondary)
                            .background(.brandBackground)
                            .cornerRadius(10)
                            Text("\(String(scoreB))")
                                .frame(width: 120,height: 150)
                                .padding()
                                .padding(.vertical, 10)
                                .font(.system(size: 60))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth:2)
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.white.opacity(0.2))
                                )
                                .foregroundStyle(Color.orange)
                        }
                        
                    }
                    HStack(spacing: 0){
                        Button(action:{
                            plusBool = !plusBool
                        }){
                            Image(systemName: "plusminus")
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                            
                        }
                        Spacer()
                        //Team A
                        Button(action:{
                            plusBool ? (
                                scoreA += 1) : scoreA > 0 ? (scoreA -= 1) : ()
                        }){
                            Text("1")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                        
                        Button(action:{
                            plusBool ? (
                                scoreA += 2) : scoreA > 0 ? (scoreA -= 2) : ()
                        }){
                            Text("2")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            plusBool ? (
                                scoreA += 3) : scoreA > 0 ? (scoreA -= 3) : ()
                        }){
                            Text("3")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                            
                        }
                        Spacer()
                        Spacer()
                        //Team B
                        Button(action:{
                            plusBool ? (
                                scoreB += 1) : scoreB > 0 ? (scoreB -= 1) : ()
                        }){
                            Text("1")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                        Button(action:{
                            plusBool ? (
                                scoreB += 2) : scoreB > 0 ? (scoreB -= 2) : ()
                        }){
                            Text("2")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button(action:{
                            plusBool ? (
                                scoreB += 3) : scoreB > 0 ? (scoreB -= 3) : ()
                        }){
                            Text("3")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    
                }
                .padding()
                .padding(.vertical, 15)
                .frame(maxWidth:.infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.black.opacity(0.8))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth:2)
                )
                Spacer()
                Spacer()
                
                HStack{
                    Button(action:{
                        print("Reset clicked")
                        resetAlert = true
                    }){
                        Text("Reset")
                            .padding()
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(Color.orange)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                        
                        
                    }
                    Button(action:{
                        saveGame()
                    }){
                        Text("Finish game")
                            .padding()
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(Color.green)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                
            }
            .padding()
            .frame(maxHeight:.infinity)
            .alert("Reset Score",isPresented: $resetAlert) {
                Button(action:{
                    resetScore()
                }){
                    Text("Reset")
                        .foregroundStyle(Color.red)
                }
                Button(action:{
                    
                }){
                    Text("Cancel")
                }
            }message: {
                Text("Are you sure you want to reset?")
            }
        }
        .alert("Game Saved", isPresented: $gameFinished){
            Button("Confirm"){
                gameFinished = false
                resetScore()
            }
            .tint(.blue)
        }message:{
            Text("""
                    Teams: \(teamA.isEmpty ? "Team A" : teamA) vs \(teamB.isEmpty ? "Team B" : teamB)
                    Final Score: \(scoreA) - \(scoreB)
                    \(result)
                    
                    Navigate to history to see all saved games
                    """)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
