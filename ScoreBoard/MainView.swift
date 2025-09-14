//
//  MainView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/9/25.
//

import SwiftUI

struct MainView: View {
    var body: some View{
        TabView{
            ContentView()
                .tabItem{
                    Label("Game", systemImage: "basketball.fill")
                }
            History()
                .tabItem{
                    Label("History", systemImage: "book.fill")
                }
        }
        .tint(Color.black)
        
    }
}

#Preview {
    MainView()
}
