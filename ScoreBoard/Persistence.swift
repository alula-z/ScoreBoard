import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Add sample games for preview
        for i in 0..<15 {
            let game = GameEntity(context: viewContext)
            game.teamA = "Los Angeles Lakers\(i + 1)"
            game.teamB = "Team B\(i + 1)"
            game.scoreA = Int32(i * 10)
            game.scoreB = Int32(i * 50)
            game.date = Date.now
        }
        
        do {
            try viewContext.save()
            
        } catch {
            
        }
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
    
        
        container = NSPersistentContainer(name: "ScoreBoard") // This matches your ScoreBoard.xcdatamodeld
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}
