//
//  HistoryViewModel.swift
//  MyScoreBoard
//
//  Created by Alula Zeruesenay on 2/3/26.
//

import Foundation
import Combine
import os
import CoreData

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published private(set) var games: [GameEntity] = []

    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    
    
   
    func loadGames(_ games: [GameEntity]) {
        self.games = games
    }
    
    
    func delete(_ game: GameEntity){
        viewContext.delete(game)
        
        do{
            try viewContext.save()
        } catch {
            print("Error deleting game:", error.localizedDescription)
        }
    }
    
    func deleteAllGames() {
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
            print("All games deleted")
        } catch {
            print("Failed to delete all games: \(error.localizedDescription)")
        }
    }
}
