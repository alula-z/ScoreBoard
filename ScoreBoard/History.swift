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
        ZStack{
            VStack{
                Text("History")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                List{
                    if games.isEmpty{
                        Text("No games saved")
                            .foregroundStyle(Color.gray)
                    }else{
                        ForEach(games, id: \.self){game in
                            HStack(alignment: .center){
                                Text("\(game.teamA ?? "")")
                                Spacer()
                                game.scoreA > game.scoreB ?
                                HStack{
                                    Text("\(game.scoreA)")
                                        .foregroundStyle(Color.green)
                                        .fontWeight(.bold)
                                    Text(" - ")
                                    Text("\(game.scoreB)")
                                        .foregroundStyle(Color.red)
                                }
                                
                                : game.scoreB > game.scoreA ?
                                HStack{
                                        Text("\(game.scoreA)")
                                            .foregroundStyle(Color.red)
                                        Text(" - ")
                                        Text("\(game.scoreB)")
                                            .foregroundStyle(Color.green)
                                            .fontWeight(.bold)
                                    }
                                :
                                HStack{
                                        Text("\(game.scoreA)")
                                            .foregroundStyle(Color.gray)
                                        Text(" - ")
                                        Text("\(game.scoreB)")
                                            .foregroundStyle(Color.gray)
                                    }
                                Spacer()
                                Text("\(game.teamB ?? "")")
                            }
                            .frame(width: .infinity)
                        }
                        
                    }
                        
                }
                
            }
            
        }
    }
}

#Preview {
    History()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

