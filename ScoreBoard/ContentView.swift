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
            Color(red: 0.48, green: 0.49, blue: 0.88)
                .ignoresSafeArea()
            VStack{
                Text("ScoreBoard")
                    .font(.system(size: 50))
                    .underline(true,color: Color.black)
                    .fontWeight(.bold)
                    .frame(alignment: .top)
                Spacer()
                VStack(spacing: 20){
                    HStack{
                        VStack{
                            Text("Team A")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(String(scoreB))")
                                .frame(width: 120,height: 150)
                                .padding()
                                .font(.system(size: 60))
                                .border(Color.black, width: 1)

                        }
                        Spacer()
                        VStack{
                            Text("Team B")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(String(scoreB))")
                                .frame(width: 120,height: 150)
                                .padding()
                                .font(.system(size: 60))
                                .border(Color.black, width: 1)
                                .background(Color.indigo)
                        }
 
                    }
                    HStack(spacing: 0){
                        
                        //Team A
                        Button(action:{
                            scoreA += 1
                        }){
                            Text("+1")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                                
                        }
                        
                        Button(action:{
                            scoreA += 2
                        }){
                            Text("+2")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                        }
                        Button(action:{
                            scoreA += 3
                        }){
                            Text("+3")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                            
                        }
                        
                        Spacer()
                        //Team B
                        Button(action:{
                            scoreB += 1
                        }){
                            Text("+1")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                                
                        }
                        Button(action:{
                        scoreB += 2
                        }){
                            Text("+2")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                        }
                        Button(action:{
                        scoreB += 3
                        }){
                            Text("+3")
                                .foregroundStyle(Color.white)
                                .padding()
                                .border(Color.black, width: 1)
                        }
                    }
                    
                }
                .padding()
                .frame(maxWidth:.infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(red: 0.3, green: 0.2, blue: 0.5, opacity: 0.6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth:2)
                )
                Spacer()
                Button(action:{
                    
                }){
                    Text("Reset")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(Color.orange)
                        .clipShape(Capsule())
                        .fontWeight(.bold)
                    
                        
                }
                .padding(.horizontal)
                
                
                Spacer()
            }
            .padding()
            .frame(maxHeight:.infinity)
        }
    }
}

#Preview {
    ContentView()
}
