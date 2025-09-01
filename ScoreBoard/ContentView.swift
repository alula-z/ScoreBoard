//
//  ContentView.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var scoreA = 0;
    @State var scoreB = 0;
    @State var teamA = "";
    @State var teamB = "";
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack {
                Text("ScoreBoard")
                    .font(.title)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
