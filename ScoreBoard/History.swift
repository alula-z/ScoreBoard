//
//  History.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/3/25.
//
import SwiftUI
import CoreData

struct History: View{
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \GameEntity.teamA, ascending: true)],
            animation: .default
        ) private var games: FetchedResults<GameEntity>
    
    var body: some View{
        NavigationView{
            ZStack{
                Color(.yellow.opacity(0.2))
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        Text("History")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding()
                        
                        VStack{
                            if games.isEmpty{
                                Text("No games saved")
                                    .foregroundStyle(Color.gray)
                            }else{
                                ForEach(games, id: \.self){game in
                                    HStack(alignment: .center){
                                        Text("\(game.teamA ?? "")")
                                        Spacer()
                                        HStack{
                                            Text("\(game.scoreA)")
                                                .foregroundStyle(game.scoreA > game.scoreB ? .green : game.scoreA < game.scoreB ? .red : .gray)
                                                
                                            Text(" - ")
                                            Text("\(game.scoreB)")
                                                .foregroundStyle(game.scoreB > game.scoreA ? .green : game.scoreB < game.scoreA ? .red : .gray)
                                        }
                                        .padding(8)
                                        .padding(.horizontal, 10)
                                        .background(Color.white.opacity(0.7))
                                        .clipShape(.capsule)
                                        Spacer()
                                        Text("\(game.teamB ?? "")")
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                
                            }
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(15)
                        
                        Spacer()
                    }
                    .padding()
                }
                
            }
        }
    }
}

#Preview {
    History()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

