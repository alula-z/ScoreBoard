//
//  ContentView.swift
//  scoreBoard
//
//  Created by Alula Zeruesenay on 9/1/25.
//

import SwiftUI
import CoreData
import os

struct ContentView: View {
    @StateObject private var vm : ContentViewModel
    @State private var scaleA: CGFloat = 1.0
    @State private var scaleB: CGFloat = 1.0
    
    init(context: NSManagedObjectContext) {
        _vm = StateObject(wrappedValue: ContentViewModel(context: context))
    }
    
    
    var body: some View {
        ZStack{
            Color("BrandBackground")
                .ignoresSafeArea()
            VStack{
                Text("scoreBoard")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .frame(alignment: .top)
                    .foregroundStyle(.black)
                Spacer()
                VStack(spacing: 20){
                    HStack(spacing: 10){
                        VStack(spacing: 20){
                            TextField(text: $vm.teamA, label: { Text("Team A...")
                                    .foregroundStyle(Color.black.opacity(0.5))
                            })
                            .font(.title2)
                            .padding(.vertical, 10)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.brandSecondary)
                            .background(Color.brandBackground)
                            .cornerRadius(10)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color.white.opacity(0.2))
                                    )
                                Text("\(vm.scoreA)")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.orange)
                                    .scaleEffect(scaleA)
                                    .onChange(of: vm.scoreA) { _, _ in
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                            scaleA = 1.3
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                                scaleA = 1.0
                                            }
                                        }
                                    }
                            }
                            .frame(width: 160, height: 200)
                        }
                        Spacer()
                        VStack(spacing: 20){
                            TextField(text: $vm.teamB, label: {
                                Text("Team B...")
                                    .foregroundStyle(Color.black.opacity(0.5))
                            })
                            .font(.title2)
                            .padding(.vertical, 10)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .foregroundStyle(Color.brandSecondary)
                            .background(.brandBackground)
                            .cornerRadius(10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color.white.opacity(0.2))
                                    )
                                Text("\(vm.scoreB)")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.orange)
                                    .scaleEffect(scaleB)
                                    .onChange(of: vm.scoreB) { _, _ in
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                            scaleB = 1.3
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                                scaleB = 1.0
                                            }
                                        }
                                    }
                            }
                            .frame(width: 160, height: 200)
                        }
                        
                    }
                    HStack(spacing: 0){
                        Button(action:{
                            vm.toggleMode()
                        }){
                            Image(systemName: "plusminus")
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                            
                        }
                        Spacer()
                        //Team A
                        Button(action:{
                            vm.updateScoreA(by: 1)
                        }){
                            Text("1")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                        
                        Button(action:{
                            vm.updateScoreA(by: 2)
                        }){
                            Text("2")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            vm.updateScoreA(by: 3)
                        }){
                            Text("3")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                            
                        }
                        Spacer()
                        Spacer()
                        //Team B
                        Button(action:{
                            vm.updateScoreB(by: 1)
                        }){
                            Text("1")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                        Button(action:{
                            vm.updateScoreB(by: 2)
                        }){
                            Text("2")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button(action:{
                            vm.updateScoreB(by: 3)
                        }){
                            Text("3")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(vm.plusBool ? Color.green : Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    
                }
                .padding()
                .padding(.vertical, 15)
                .frame(maxWidth:.infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.black.opacity(0.8))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth:2)
                )
                Spacer()
                Spacer()
                
                HStack{
                    Button(action:{
                        vm.resetAlert = true
                    }){
                        Text("Reset")
                            .padding()
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(Color.orange)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                        
                        
                    }
                    Button(action:{
                        vm.saveGame()
                    }){
                        Text("Finish game")
                            .padding()
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(Color.green)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                
            }
            .padding()
            .frame(maxHeight:.infinity)
            .alert("Reset Score",isPresented: $vm.resetAlert) {
                Button("Reset", role: .destructive){
                    vm.resetScore()
                }
                Button("Cancel", role: .cancel){}
                
            }message: {
                Text("Are you sure you want to reset?")
            }
            .tint(Color("AccentColor"))
            
            if vm.gameFinished {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        vm.resetScore()
                        vm.gameFinished = false
                    }
                
                gameConfirm(
                    teamA: vm.teamA.isEmpty ? "Team A" : vm.teamA,
                    teamB: vm.teamB.isEmpty ? "Team B" : vm.teamB,
                    scoreA: vm.scoreA,
                    scoreB: vm.scoreB,
                    result: vm.result,
                    onConfirm:{
                        vm.resetScore()
                        vm.gameFinished = false
                    }
                )
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            context: PersistenceController.preview.container.viewContext
        )
        .preferredColorScheme(.dark)
    }
}

