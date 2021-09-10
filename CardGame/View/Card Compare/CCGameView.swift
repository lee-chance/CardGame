//
//  CCGameView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct CCGameView: View {
    
    @Binding var presented: Bool
    @Binding var playerName: String
    var isServer: Bool = false
    
    @State private var playerCard = Card.redBack().value
    @State private var computerCard = Card.blackBack().value
    @State private var pName: String = "USER 1"
    @State private var cName: String = "USER 2"
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack {
                HStack {
                    Button(action: {
                        presented = false
                        if isServer {
                            if playerName == pName {
                                SocketIOManager.shared.leave(user: "U1")
                            } else {
                                SocketIOManager.shared.leave(user: "U2")
                            }
                        }
                        SocketIOManager.shared.offListeners()
                    }, label: {
                        Text("X")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.pink)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    })
                    Spacer()
                    if isServer {
                        if cName == "USER 2" {
                            Text("기다리는중..")
                                .font(.body)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        } else {
                            Text("게임중..")
                                .font(.body)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        Spacer()
                        Text("X")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack {
                    Spacer()
                    Image(playerCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                    Spacer()
                    Image(computerCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    
                    if isServer {
                        SocketIOManager.shared.deal()
                    } else {
                        // generate a random number
                        let playerSuitRandom = Int.random(in: 0...3)
                        let playerRankRandom = Int.random(in: 1...13)
                        let computerSuitRandom = Int.random(in: 0...3)
                        let computerRankRandom = Int.random(in: 1...13)
                        
                        play(user1SuitRandom: playerSuitRandom,
                             user1RankRandom: playerRankRandom,
                             user2SuitRandom: computerSuitRandom,
                             user2RankRandom: computerRankRandom)
                    }
                    
                }, label: {
                    Text("DEAL!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding(.all)
                })
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text(pName)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack {
                        Text(cName)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.0)
                        Text(String(computerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .onAppear(perform: {
            if isServer {
                SocketIOManager.shared.listenForRoomInfo { roomInfo in
                    pName = roomInfo.user1
                    cName = roomInfo.user2
                }
                SocketIOManager.shared.listenForCCGameInfo { gameInfo in
                    play(user1SuitRandom: gameInfo.user1SuitRandom,
                         user1RankRandom: gameInfo.user1RankRandom,
                         user2SuitRandom: gameInfo.user2SuitRandom,
                         user2RankRandom: gameInfo.user2RankRandom)
                    
                }
            } else {
                pName = playerName
                cName = "Computer"
            }
        })
    }
    
    private func suit(int: Int) -> Card.Suit {
        switch int {
        case 0: return .clubs
        case 1: return .diamonds
        case 2: return .hearts
        case 3: return .spades
        default: return .back
        }
    }
    
    private func isPlayerWin(player: Card, computer: Card) -> Bool? {
        let pRank = player.rank.rawValue
        let cRank = computer.rank.rawValue
        if pRank > cRank {
            return true
        } else if pRank < cRank {
            return false
        } else {
            let pSuit = player.suit.rawInt
            let cSuit = computer.suit.rawInt
            if pSuit > cSuit {
                return true
            } else if pSuit < cSuit {
                return false
            } else {
                return nil
            }
        }
    }
    
    private func play(user1SuitRandom: Int, user1RankRandom: Int, user2SuitRandom: Int, user2RankRandom: Int) {
        
        // update the cards
        let pCard = Card(rank: Card.Rank(rawValue: user1RankRandom)!, suit: suit(int: user1SuitRandom))
        let cCard = Card(rank: Card.Rank(rawValue: user2RankRandom)!, suit: suit(int: user2SuitRandom))
        playerCard = pCard.value
        computerCard = cCard.value
        
        // update the score
        if let isPlayerWin = isPlayerWin(player: pCard, computer: cCard) {
            if isPlayerWin {
                playerScore += 1
            } else {
                computerScore += 1
            }
        } else {
            print("에러에러")
        }
        
    }
}

struct CCGameView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CCGameView(presented: .constant(true), playerName: .constant("Player"))
        }
    }
}
