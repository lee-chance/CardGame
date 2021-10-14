//
//  BWLobbyView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct LobbyView: View {
    
    @Binding var presented: Bool
    @State private var isShowAlert = false
    @State private var localGameIsPresent = false
    @State private var serverGameIsPresent = false
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Background()

            VStack {
                TitleBar(presented: $presented, title: CGManager.shared.gameList.title)
                Spacer()
                TextField("Enter your nickname!", text: $name)
                    .padding()
                    .frame(width: 250.ratioConstant)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    guard !name.isEmpty else {
                        isShowAlert = true
                        return
                    }
                    localGameIsPresent = true
                }, label: {
                    Text("vs COMPUTER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                })
                .fullScreenCover(isPresented: $localGameIsPresent, content: {
                    switch CGManager.shared.gameList {
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
                    guard !name.isEmpty else {
                        isShowAlert = true
                        return
                    }
                    // TODO: 네트워크 체크
                    serverGameIsPresent = true
                    SocketIOManager.shared.enter(nickname: name)
                }, label: {
                    Text("vs USER")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                })
                .fullScreenCover(isPresented: $serverGameIsPresent, content: {
                    switch CGManager.shared.gameList {
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
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("Enter your nickname!"), message: nil, dismissButton: .default(Text("OK")))
            }

        }
        .onAppear(perform: {
            SocketIOManager.shared.establishConnection(namespace: "/\(CGManager.shared.gameList.rawValue)")
        })
        .onDisappear(perform: {
            SocketIOManager.shared.closeConnection()
            CGManager.shared.gameList = .none
        })
    }
    
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView(presented: .constant(true))
    }
}
