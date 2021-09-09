//
//  BWLobbyView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct BWLobbyView: View {
    
    @Binding var presented: Bool
    @State private var localGameIsPresent = false
    @State private var serverGameIsPresent = false
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Background()

            VStack {
                TitleBar(presented: $presented, title: "Black and White")
                Spacer()
                TextField("Enter your nickname!", text: $name)
                    .padding()
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
                        .padding()
                })
                .fullScreenCover(isPresented: $localGameIsPresent, content: {
                    BWGameView(presented: $localGameIsPresent, playerName: $name)
                })

                Button(action: {
                    if name.isEmpty {
                        serverGameIsPresent = false
                        print("닉네임을 입력해라~")
                    } else {
                        serverGameIsPresent = true
                        SocketIOManager.shared.enter(nickname: name)
                    }
                }, label: {
                    Text("vs USER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.all)
                })
                .fullScreenCover(isPresented: $serverGameIsPresent, content: {
                    BWGameView(presented: $serverGameIsPresent, playerName: $name, isServer: true)
                })
                Spacer()
                Spacer()
            }

        }
        .onAppear(perform: {
            SocketIOManager.shared.establishConnection(namespace: "/blackAndWhite")
        })
    }
    
}

struct BWLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        BWLobbyView(presented: .constant(true))
    }
}
