//
//  CCLobbyView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct CCLobbyView: View {
    
    @Binding var presented: Bool
    @State private var localGameIsPresent = false
    @State private var serverGameIsPresent = false
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                TitleBar(presented: $presented, title: "Card Compare")
                Spacer()
                TextField("Enter your nickname!", text: $name)
                    .padding(.all)
                    .frame(width: 250.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if name.isEmpty {
                        localGameIsPresent = false
                        print("닉네임을 입력해라~")
                    } else {
                        localGameIsPresent = true
                    }
                }, label: {
                    Text("vs COMPUTER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.all)
                })
                .fullScreenCover(isPresented: $localGameIsPresent, content: {
                    CCGameView(presented: $localGameIsPresent, playerName: $name)
                })
                
                Button(action: {
                    if name.isEmpty {
                        serverGameIsPresent = false
                        print("닉네임을 입력해라~")
                    } else {
                        serverGameIsPresent = true
                        SocketIOManager.shared.enter(room: "a", nickname: name)
                    }
                }, label: {
                    Text("vs USER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.all)
                })
                .fullScreenCover(isPresented: $serverGameIsPresent, content: {
                    CCGameView(presented: $serverGameIsPresent, playerName: $name, isServer: true)
                })
                Spacer()
                Spacer()
            }
            
        }
        .onAppear(perform: {
            print("Appeared!")
        })
    }
    
}

struct CCLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        CCLobbyView(presented: .constant(true))
    }
}
