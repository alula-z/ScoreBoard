//
//  ContentView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/1/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var scoreA = 0;
    @State var scoreB = 0;
    @State var teamA = "Team A";
    @State var teamB = "Team B";
    @State var resetAlert = false;
    @State var resetMessage = "";
    
    struct Game{
        let teamA:String
        let teamB:String
        let scoreA:Int
        let scoreB: Int
    }
    func resetScore(){
        scoreA = 0
        scoreB = 0
    }
    func saveGame(){
        let currGame = Game(teamA: teamA, teamB: teamB, scoreA: scoreA, scoreB: scoreB)
        let entity = GameEntity(context: viewContext)
        entity.teamA = currGame.teamA
        entity.teamB = currGame.teamB
        entity.scoreA = Int32(currGame.scoreA)
        entity.scoreB = Int32(currGame.scoreB)
        do{
            try viewContext.save()
            print("Game saved Successfully")
        }catch{
            print("Failed to save")
        }
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.48, green: 0.49, blue: 0.88)
                    .ignoresSafeArea()
                VStack{
                    Text("ScoreBoard")
                        .font(.system(size: 50))
                        .underline(true,color: Color.black)
                        .fontWeight(.bold)
                        .frame(alignment: .top)
                    Spacer()
                    VStack(spacing: 20){
                        HStack{
                            VStack{
                                TextField(text: $teamA, label: { Text("Team A") })
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
                                Text("\(String(scoreA))")
                                    .frame(width: 120,height: 150)
                                    .padding()
                                    .font(.system(size: 60))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.black, lineWidth:2)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color(red: 0.2, green: 0.2, blue: 0.6, opacity: 0.6))
                                    )
                                    .foregroundStyle(Color.white)
                            }
                            Spacer()
                            VStack{
                                TextField(text: $teamB, label: {
                                    Text("Team B")
                                })
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                Text("\(String(scoreB))")
                                    .frame(width: 120,height: 150)
                                    .padding()
                                    .font(.system(size: 60))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.black, lineWidth:2)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color(red: 0.2, green: 0.2, blue: 0.6, opacity: 0.6))
                                    )
                                    .foregroundStyle(Color.white)
                            }
                            
                        }
                        HStack(spacing: 0){
                            
                            //Team A
                            Button(action:{
                                scoreA += 1
                            }){
                                Text("+1")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                                
                            }
                            
                            Button(action:{
                                scoreA += 2
                            }){
                                Text("+2")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                            }
                            Button(action:{
                                scoreA += 3
                            }){
                                Text("+3")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                                
                            }
                            
                            Spacer()
                            //Team B
                            Button(action:{
                                scoreB += 1
                            }){
                                Text("+1")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                                
                            }
                            Button(action:{
                                scoreB += 2
                            }){
                                Text("+2")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                            }
                            Button(action:{
                                scoreB += 3
                            }){
                                Text("+3")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .border(Color.black, width: 1)
                            }
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth:.infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(red: 0.3, green: 0.2, blue: 0.5, opacity: 0.6))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth:2)
                    )
                    Spacer()
                    Button(action:{
                        print("Reset clicked")
                        resetAlert = true
                    }){
                        Text("Reset")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(Color.orange)
                            .clipShape(Capsule())
                            .fontWeight(.bold)
                        
                        
                    }
                    .padding(.horizontal)
                    Button(action:{
                        saveGame()
                        resetScore()
                    }){
                        Text("Finish game")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(Color.green)
                            .clipShape(Capsule())
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    NavigationLink(destination: History()) {
                        Text("View All Games")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
