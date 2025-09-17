//
//  MainView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/9/25.
//

import SwiftUI

struct MainView: View {
    @Binding var selectTab: Int
    init(selectTab: Binding<Int>){
        self._selectTab = selectTab
        UITabBar.appearance().unselectedItemTintColor = .black
    }
    var body: some View{
        TabView(selection: $selectTab){
            ContentView()
                .tabItem{
                    Label("Game", systemImage: "basketball.fill")
                }
                .tag(0)
            
            History()
                .tabItem{
                    Label("History", systemImage: "book.fill")
                }
                .tag(1)
        }
        .tint(Color.blue)
        
    }
}


