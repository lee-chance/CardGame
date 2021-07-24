//
//  GameView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct GameView: View {
    
    @Binding var presented: Bool
    var isServer: Bool = false
    @Binding var playerName: String
    
    @State private var playerCard = Card(rank: .back, suit: .back).value
    @State private var computerCard = Card(rank: .back, suit: .back).value
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack {
                HStack {
                    Button(action: {
                        presented = false
                    }, label: {
                        Text("X")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.pink)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    })
                    Spacer()
                    if isServer {
                        Text("기다리는중..")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text("X")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                }
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
                    
                    // generate a random number
                    let playerSuitRandom = Int.random(in: 0...3)
                    let playerRankRandom = Int.random(in: 1...13)
                    let computerSuitRandom = Int.random(in: 0...3)
                    let computerRankRandom = Int.random(in: 1...13)
                    
                    // update the cards
                    let pCard = Card(rank: Card.Rank(rawValue: playerRankRandom)!, suit: suit(int: playerSuitRandom))
                    let cCard = Card(rank: Card.Rank(rawValue: computerRankRandom)!, suit: suit(int: computerSuitRandom))
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
                        Text(playerName)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack {
                        Text(isServer ? "User 2" : "Computer")
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
            .padding(.horizontal)
        }
    }
    
    func suit(int: Int) -> Card.Suit {
        switch int {
        case 0: return .clubs
        case 1: return .diamonds
        case 2: return .hearts
        case 3: return .spades
        default: return .back
        }
    }
    
    func isPlayerWin(player: Card, computer: Card) -> Bool? {
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
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            GameView(presented: .constant(true), playerName: .constant("Player"))
//            GameView()
//                .previewDevice("iPhone 12 mini")
//            GameView()
//                .previewDevice("iPod touch (7th generation)")
        }
    }
}
