import CoreData
//
//  History.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/3/25.
//
import SwiftUI
import os
struct History: View {
    let logger = Logger(subsystem: "me.zeruesenay.alula.ScoreBoard", category: "History")
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \GameEntity.date, ascending: true)
        ],
        animation: .default
    ) private var games: FetchedResults<GameEntity>
    private func deleteGame (at offsets: IndexSet){
        for index in offsets{
            let game = games[index]
            viewContext.delete(game)
        }
        
        do {
            try viewContext.save()
        } catch {
            logger.error("Error deleting game \(error.localizedDescription)")
        }
    }
    var body: some View {
            ZStack {
                Color("BrandBackground")
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Text("History")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding()
                        List {
                            if games.isEmpty {
                                Text("No games saved")
                                    .foregroundStyle(Color.gray)
                            } else {
                                ForEach(games, id: \.self) { game in
                                    VStack(alignment: .center){
                                        HStack(alignment: .center) {
                                            Text("\(game.teamA ?? "")")
                                                .frame(maxWidth: .infinity, alignment:.leading)
                                            
                                            HStack(spacing: 4) {
                                                Text("\(game.scoreA)")
                                                    .foregroundStyle(
                                                        game.scoreA > game.scoreB
                                                        ? .green
                                                        : game.scoreA
                                                        < game.scoreB
                                                        ? .red : .white
                                                    )
                                                Text(" - ")
                                                    .foregroundStyle(
                                                        Color(.white)
                                                    )
                                                Text("\(game.scoreB)")
                                                    .foregroundStyle(
                                                        game.scoreB > game.scoreA
                                                        ? .green
                                                        : game.scoreB
                                                        < game.scoreA
                                                        ? .red : .white
                                                    )
                                            }
                                            .padding(.vertical,8)
                                            .padding(.horizontal, 15)
                                            .background(Color.black.opacity(0.7))
                                            .clipShape(.capsule)
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
                                            Text("\(game.teamB ?? "")")
                                                .frame(maxWidth: .infinity,alignment:.trailing)
                                        }
                                        .padding(.horizontal, 5)
                                        if let date = game.date {
                                            Text(date.formatted(date: .abbreviated, time: .shortened))
                                                .font(.caption)
                                                .foregroundStyle(.black.opacity(0.6))
                                                
                                        }
                                    }
                                    .padding(.vertical,3)
                                }
                                .onDelete(perform: deleteGame)

                            }
                        }
                        .scrollContentBackground(.hidden)
                        Spacer()
                    }

                }

            }
    }
}

#Preview {
    History()
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
