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
    @State var plusBool = true;
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
                Color(.black.opacity(0.2))
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
                                    .foregroundStyle(Color.yellow.opacity(0.9))
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
                                            .fill(Color.white.opacity(0.2))
                                    )
                                    .foregroundStyle(Color.orange)
                            }
                            Spacer()
                            VStack{
                                TextField(text: $teamB, label: {
                                    Text("Team B")
                                })
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .foregroundStyle(Color.yellow.opacity(0.9))
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
                            resetScore()
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
                    NavigationLink(destination: History()) {
                        Image(systemName: "book.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.black)
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
