//
//  BWGameView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct BWGameView: View {
    
    @Binding var presented: Bool
    @Binding var playerName: String
    var isServer: Bool = false
    
    @State private var pName: String = "USER 1"
    @State private var cName: String = "USER 2"
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    @State private var playerSelectedCard: Card = Card(rank: .ace, suit: .spades)
    @State private var otherSelectedCard: Card = Card(face: .redBack)
    @State private var playerCardClickable: Bool = true
    @State private var myDeck = [
        Card(rank: .ace, suit: .spades),
        Card(rank: .two, suit: .hearts),
        Card(rank: .three, suit: .clubs),
        Card(rank: .four, suit: .diamonds),
        Card(rank: .five, suit: .spades),
        Card(rank: .six, suit: .hearts),
        Card(rank: .seven, suit: .clubs),
        Card(rank: .eight, suit: .diamonds),
        Card(rank: .nine, suit: .spades),
        Card(rank: .ten, suit: .hearts),
    ]
    @State private var otherDeck = [
        Card(rank: .ace, suit: .clubs),
        Card(rank: .two, suit: .diamonds),
        Card(rank: .three, suit: .spades),
        Card(rank: .four, suit: .hearts),
        Card(rank: .five, suit: .clubs),
        Card(rank: .six, suit: .diamonds),
        Card(rank: .seven, suit: .spades),
        Card(rank: .eight, suit: .hearts),
        Card(rank: .nine, suit: .clubs),
        Card(rank: .ten, suit: .diamonds),
    ]
    
    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack {
                // title bar
                TitleBar(presented: $presented, title: "Black and White")
                
                // other deck
                let bCount = otherDeck.filter { $0.isBlack }.count
                let rCount = otherDeck.filter { $0.isRed }.count
                OtherDeck(deck: $otherDeck, redCount: .constant(rCount), blackCount: .constant(bCount))
                
                // other card
                VStack {
                    Spacer()
                    Image(otherSelectedCard.value)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0)
                    Spacer()
                }
                
                // score
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
                
                // my card
                VStack {
                    Spacer()
                    Button(action: {
                        playerCardClickable = false
                        play()
                    }, label: {
                        Text("Deal")
                            .foregroundColor(Color.red)
                            .padding(.horizontal)
                            .padding(.vertical, 4.0)
                    })
                    .background(Color(.black))
                    Image(playerSelectedCard.value)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0)
                    Spacer()
                }
                
                // my deck
                HStack {
                    MyDeck(deck: $myDeck, selectedCard: $playerSelectedCard, clickable: $playerCardClickable)
                }
            }
        }
        .onAppear(perform: {
            if isServer {
                SocketIOManager.shared.listenForRoomInfo { roomInfo in
                    pName = roomInfo.user1
                    cName = roomInfo.user2
                }
                SocketIOManager.shared.listenForGameInfo { gameInfo in
                    // TODO: listenForGameInfo
                }
            } else {
                pName = playerName
                cName = "Computer"
            }
        })
    }
    
    private func play() {
        let computerRand = Int.random(in: 0..<otherDeck.count)
        let computerCard = otherDeck[computerRand]
        otherSelectedCard = computerCard
        
        // check
        let computerRank = otherSelectedCard.rank.rawValue
        let playerRank = playerSelectedCard.rank.rawValue
        if playerRank > computerRank {
            playerScore += 1
        } else if playerRank < computerRank {
            computerScore += 1
        } else {
            playerScore += 1
            computerScore += 1
        }
        
        // pop card
        otherDeck = otherDeck.filter { $0.rank != otherSelectedCard.rank }
        myDeck = myDeck.filter { $0.rank != playerSelectedCard.rank }
        
        playerCardClickable = true
    }
}

struct BWGameView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            BWGameView(presented: .constant(true), playerName: .constant("Player"))
//            BWGameView(presented: .constant(true), playerName: .constant("Player"))
//                .previewDevice("iPod touch (7th generation)")
        }
    }
}
