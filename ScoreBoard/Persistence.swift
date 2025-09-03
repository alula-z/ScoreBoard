//
//  Persistence.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/3/25.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        // Add sample games for preview
            let viewContext = result.container.viewContext
            for i in 0..<3 {
                let game = GameEntity(context: viewContext)
                game.teamA = "Team A"
                game.teamB = "Team B"
                game.scoreA = Int32(i * 10)
                game.scoreB = Int32(i * 12)
            }

            try? viewContext.save()
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model") // Replace "Model" with your .xcdatamodeld name
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

