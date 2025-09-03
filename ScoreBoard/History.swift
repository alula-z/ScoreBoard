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
            List{
                if games.isEmpty{
                    Text("No games saved")
                        .foregroundStyle(Color.gray)
                }else{
                    ForEach(games, id: \.self){game in
                        HStack(alignment: .center){
                            Text("\(game.teamA ?? "")")
                            Spacer()
                            Text("\(game.scoreA) - \(game.scoreB)")
                            Spacer()
                            Text("\(game.teamB ?? "")")
                        }
                        .frame(width: .infinity)
                    }
                    
                }
        }
    }
}

#Preview {
    History()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

