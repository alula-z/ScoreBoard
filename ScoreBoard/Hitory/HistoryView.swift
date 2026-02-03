import CoreData
//
//  History.swift
//  ScoreBoard
//
//  Created by Alula Zeruesenay on 9/3/25.
//
import SwiftUI
import os
struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm : HistoryViewModel
    
    init(context: NSManagedObjectContext) {
        _vm = StateObject(wrappedValue: HistoryViewModel(viewContext: context))
    }
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \GameEntity.date, ascending: true)
        ],
        animation: .default
    )
    private var games: FetchedResults<GameEntity>
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
                            if vm.games.isEmpty {
                                Text("No games saved")
                                    .foregroundStyle(Color.gray)
                                    .background(.white)
                                    .listRowBackground(Color.white)
                            } else {
                                ForEach(vm.games, id: \.self) { game in
                                    VStack(alignment: .center){
                                        HStack{
                                            Spacer()
                                            Menu{
                                                Button("Delete", role:.destructive){
                                                    vm.delete(game)
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
                            Button("Clear All", role: .destructive){
                                vm.deleteAllGames()
                            }
                            Button("Cancel", role:.cancel){}
                        }message: {
                            Text("This will permanently delete all saved games.")
                        }
                        .tint(Color("AccentColor"))
                        Spacer()
                        
                    }
                    Spacer()
                    
                }
                
            }
            
        }
        .onAppear{
            vm.loadGames(Array(games))
        }
        .onChange(of: games.count) { oldValue, newValue in
            vm.loadGames(Array(games))
        }
    }
}


#Preview {
    HistoryView(context: PersistenceController.preview.container.viewContext)
        .preferredColorScheme(.dark)
}
