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
    private func deleteAllGames() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GameEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes: [AnyHashable: Any] = [
                    NSDeletedObjectsKey: objectIDs
                ]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [viewContext])
            }
            logger.log("✅ All games deleted")
        } catch {
            logger.error("❌ Failed to delete all games: \(error.localizedDescription)")
        }
    }
    @State var showConfirm = false
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
                            .foregroundStyle(.black)
                        VStack(spacing: 0){
                            List {
                                if games.isEmpty {
                                    Text("No games saved")
                                        .foregroundStyle(Color.gray)
                                        .background(.white)
                                } else {
                                    ForEach(games, id: \.self) { game in
                                        VStack(alignment: .center){
                                            HStack{
                                                Spacer()
                                                Menu{
                                                    Button("Delete", role:.destructive){
                                                        viewContext.delete(game)
                                                        try? viewContext.save()
                                                    }
                                                }label: {
                                                    Image(systemName: "ellipsis")
                                                        .foregroundStyle(.gray)
                                                        .imageScale(.large)
                                                }
                                            }

                                            HStack(alignment: .center) {
                                                Text("\(game.teamA ?? "")")
                                                    .frame(maxWidth: .infinity, alignment:.leading)
                                                    .font(.body)
                                                    .foregroundStyle(.black)
                                                
                                                HStack(spacing: 4) {
                                                    Text("\(game.scoreA)")
                                                        .foregroundStyle(
                                                            game.scoreA > game.scoreB
                                                            ? .green
                                                            : game.scoreA
                                                            < game.scoreB
                                                            ? .red : .white
                                                        )
                                                        .lineLimit(1)
                                                        .font(.headline)
                                                    
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
                                                        .lineLimit(1)
                                                        .font(.headline)
                                                }
                                                .padding(8)
                                                .padding(.horizontal, 10)
                                                .background(Color.black)
                                                .clipShape(.capsule)
                                                .fixedSize(horizontal: true, vertical: false)
                                                
                                                Text("\(game.teamB ?? "")")
                                                    .frame(maxWidth: .infinity,alignment:.trailing)
                                                    .font(.body)
                                                    .foregroundStyle(.black)
                                                
                                            }
                                            .padding(.horizontal, 5)
                                            if let date = game.date {
                                                Text(date.formatted(date: .abbreviated, time: .shortened))
                                                    .font(.caption)
                                                    .foregroundStyle(.black.opacity(0.6))
                                                
                                            }
                                        }
                                        .listRowBackground(Color.white)
                                        .padding(.vertical,3)
                                    }
                                    
                                    
                                }
                            }
                            .background(.clear)
                            .scrollContentBackground(.hidden)
                            
                            
                            Button(role: .destructive){
                                showConfirm = true
                            }label:{
                                Text("Clear All History")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red.opacity(0.8))
                                    .foregroundStyle(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal,20)
                            }

                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .alert("Clear All History", isPresented: $showConfirm) {
                                Button("DeleteAll", role: .destructive){
                                    deleteAllGames()
                                }
                                Button("Cancel", role: .cancel){}
                            }message: {
                                Text("This will permanently delete all saved games.")
                            }
                            Spacer()
                            
                    }
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
        .preferredColorScheme(.light)
}
