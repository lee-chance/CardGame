//
//  ContentView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var playerCard = Card(rank: .back, suit: .back).value
    @State private var computerCard = Card(rank: .back, suit: .back).value
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    var body: some View {
        
        ZStack {
            // background Image
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            Color(.sRGB, white: 0.3, opacity: 0.5)
                .ignoresSafeArea()
            
            VStack {
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
                            print("player win")
                            playerScore += 1
                        } else {
                            print("computer win")
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
                        Text("Player")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack {
                        Text("Computer")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//            ContentView()
//                .previewDevice("iPhone 12 mini")
//            ContentView()
//                .previewDevice("iPod touch (7th generation)")
        }
    }
}
