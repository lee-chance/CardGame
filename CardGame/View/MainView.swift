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
                
                let games = Game.List.allCases.filter { $0 != .none }
                ForEach(games, id: \.self) { game in
                    Button(action: {
                        isPresent = true
                        CGManager.shared.gameList = game
                    }, label: {
                        Text(game.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    })
                    .padding()
                    .fullScreenCover(isPresented: $isPresent, content: {
                        LobbyView(presented: $isPresent)
                    })
                }
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
