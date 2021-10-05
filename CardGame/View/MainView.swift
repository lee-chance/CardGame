//
//  MainView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var isPresent = false
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            
            Background()
            
            VStack {
                
                Text("Game List")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding()
                
                // Card Compare
                Button(action: {
                    isPresent = true
                    CGManager.shared.gameType = .cardCompare
                }, label: {
                    Text("Card Compare")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $isPresent, content: {
                    LobbyView(presented: $isPresent)
                })
                
                
                // Indian Holdem
                Button(action: {
                    showingAlert = true
//                    isPresent = true
//                    CGManager.shared.gameType = .indianHoldem
                }, label: {
                    Text("Indian Holdem")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $isPresent, content: {
                    LobbyView(presented: $isPresent)
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Not yet open."), message: Text(""), dismissButton: .default(Text("Ok")))
                }
                
                
                // Black and White
                Button(action: {
                    isPresent = true
                    CGManager.shared.gameType = .blackAndWhite
                }, label: {
                    Text("Black and White")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $isPresent, content: {
                    LobbyView(presented: $isPresent)
                })
            }
            .background(Color(UIColor(white: 0.3, alpha: 0.5)))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
