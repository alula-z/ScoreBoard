//
//  ScoreBoardApp.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/1/25.
//

import SwiftUI

@main
struct ScoreBoardApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
