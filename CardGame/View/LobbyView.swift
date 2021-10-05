//
//  BWLobbyView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct LobbyView: View {
    
    @Binding var presented: Bool
    @State private var localGameIsPresent = false
    @State private var serverGameIsPresent = false
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Background()

            VStack {
                TitleBar(presented: $presented, title: CGManager.shared.gameType.title)
                Spacer()
                TextField("Enter your nickname!", text: $name)
                    .padding()
                    .frame(width: 250.ratioConstant)
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
                    switch CGManager.shared.gameType {
                    case .cardCompare:
                        CCGameView(presented: $localGameIsPresent, playerName: name, isServer: false)
//                    case .indianHoldem:
                    case .blackAndWhite:
                        BWGameView(presented: $localGameIsPresent, playerName: name, isServer: false)
                    default:
                        // error view 필요
                        Text("Error")
                    }
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
                    switch CGManager.shared.gameType {
                    case .cardCompare:
                        CCGameView(presented: $serverGameIsPresent, playerName: name, isServer: true)
//                    case .indianHoldem:
                    case .blackAndWhite:
                        BWGameView(presented: $serverGameIsPresent, playerName: name, isServer: true)
                    default:
                        // error view 필요
                        Text("Error")
                    }
                })
                Spacer()
                Spacer()
            }

        }
        .onAppear(perform: {
            SocketIOManager.shared.establishConnection(namespace: "/\(CGManager.shared.gameType.rawValue)")
        })
    }
    
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView(presented: .constant(true))
    }
}
