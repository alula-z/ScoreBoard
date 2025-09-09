import CoreData
//
//  History.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/3/25.
//
import SwiftUI

struct History: View {
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
            print("Error deleting game")
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color(.yellow.opacity(0.2))
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
                                    HStack(alignment: .center) {
                                        Text("\(game.teamA ?? "")")
                                        Spacer()
                                        HStack {
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
                                                    Color(
                                                        red: 197,
                                                        green: 199,
                                                        blue: 197
                                                    )
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
                                        .padding(8)
                                        .padding(.horizontal, 10)
                                        .frame( maxWidth: 130)
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(.capsule)
                                        Spacer()
                                        Text("\(game.teamB ?? "")")
                                    }
                                    .frame(maxWidth: .infinity)
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
}

#Preview {
    History()
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
