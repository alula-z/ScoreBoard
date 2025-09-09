import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Add sample games for preview
        for i in 0..<3 {
            let game = GameEntity(context: viewContext)
            game.teamA = "Team A\(i + 1)"
            game.teamB = "Team B\(i + 1)"
            game.scoreA = Int32(i * 10)
            game.scoreB = Int32(i * 50)
        }

        do {
            try viewContext.save()
            print("✅ Preview data saved successfully")
        } catch {
            print("❌ Failed to save preview data: \(error)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        print("🔄 Initializing PersistenceController with model name: 'ScoreBoard'")
        
        container = NSPersistentContainer(name: "ScoreBoard") // This matches your ScoreBoard.xcdatamodeld
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            print("📝 Using in-memory store for preview")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("❌ Core Data failed to load: \(error)")
                print("❌ Error details: \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("✅ Core Data loaded successfully")
                print("📍 Store location: \(storeDescription.url?.absoluteString ?? "Unknown")")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        print("✅ PersistenceController initialized")
    }
}
