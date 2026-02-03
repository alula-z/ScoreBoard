//
//  ContentViewModel.swift
//  MyScoreBoard
//
//  Created by Alula Zeruesenay on 2/3/26.
//

import Foundation
import Combine
import CoreData

@MainActor
final class ContentViewModel : ObservableObject {
    @Published var scoreA = 0
    @Published var scoreB = 0
    @Published var teamA = ""
    @Published var teamB = ""
    @Published var resetAlert = false
    @Published var resetMessage = ""
    @Published var plusBool = true
    @Published var gameFinished = false
    
    var result : String {
        if scoreA > scoreB {
            return "Winning Team: \(teamA.isEmpty ? "Team A" : teamA)"
        }else if scoreA < scoreB {
            return "Winning Team: \(teamB.isEmpty ? "Team B" : teamB)"
        } else {
            return "Draw"
        }
    }
    
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func resetScore(){
        scoreA = 0
        scoreB = 0
        teamA = ""
        teamB = ""
    }
    
    func saveGame(){
        print("Save game tapped")
        let entity = GameEntity(context: context)
        entity.teamA = teamA.isEmpty ? "Team A" : teamA
        entity.teamB = teamB.isEmpty ? "Team B" : teamB
        entity.scoreA = Int32(scoreA)
        entity.scoreB = Int32(scoreB)
        entity.date = Date.now
        do{
            try context.save()
            print("Game saved")
            gameFinished = true
        }catch{
            print("Button tapped")
        }
    }
    
    func updateScoreA(by value: Int){
        let newScore = scoreA + (plusBool ? value : -value)
        scoreA = max(newScore, 0)
    }
    
    func updateScoreB(by value: Int){
        let newScore = scoreB + (plusBool ? value : -value)
        scoreB = max(newScore, 0)
    }
    
    func toggleMode() {
        plusBool = !plusBool
    }
    
    
}
