//
//  MainView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var localGameIsPresent = false
    @State private var serverGameIsPresent = false
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Spacer()
                TextField("Enter your nickname!", text: $name)
                    .padding(.all)
                    .frame(width: 250.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    localGameIsPresent = !name.isEmpty
                }, label: {
                    Text("vs COMPUTER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.all)
                })
                .fullScreenCover(isPresented: $localGameIsPresent, content: {
                    GameView(presented: $localGameIsPresent, playerName: $name)
                })
                
                Button(action: {
                    serverGameIsPresent = !name.isEmpty
                }, label: {
                    Text("vs USER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.all)
                })
                .fullScreenCover(isPresented: $serverGameIsPresent, content: {
                    GameView(presented: $serverGameIsPresent, isServer: true, playerName: $name)
                })
                Spacer()
                Spacer()
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
