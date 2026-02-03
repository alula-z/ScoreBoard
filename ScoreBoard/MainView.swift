//
//  MainView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/9/25.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var selectTab: Int
    init(selectTab: Binding<Int>){
        self._selectTab = selectTab
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 167/255, green: 140/255, blue: 105/255, alpha:0.6)
    }
    var body: some View{
        TabView(selection: $selectTab){
            ContentView(context: viewContext)
                .tabItem{
                    Label("Game", systemImage: "basketball.fill")
                }
                .tag(0)
            
            HistoryView(context: viewContext)
                .tabItem{
                    Label("History", systemImage: "book.fill")
                }
                .tag(1)
        }
        .tint(Color(.brandSecondary))
        
        
    }
}


