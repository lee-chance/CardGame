//
//  BWGameView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct BWGameView: View {
    
    private enum Turn {
        case player1
        case player2
    }
    
    private enum Result {
        case player1Win
        case player2Win
        case draw
    }
    
    @Binding var presented: Bool
    let playerName: String
    let isServer: Bool
    
    @State private var user: CGDefine.User?
    @State private var pName: String = "USER 1"
    @State private var cName: String = "USER 2"
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    @State private var playerSelectedCard: Card = Card.blackBack()
    @State private var otherSelectedCard: Card = Card.redBack()
    @State private var myDeck = [Card]()
    @State private var otherDeck = [Card]()
    
    @State private var playerCardClickable: Bool = true
    @State private var myCardIsSelected: Bool = false
    @State private var otherCardIsSelected: Bool = false
    
    private let redCard = Card.redBack().value
    private let blackCard = Card.blackBack().value
    private let user1Deck = [
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
    private let user2Deck = [
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
            
            VStack(spacing: 0) {
                
                // other deck
                let bCount = otherDeck.filter { $0.isBlack }.count
                let rCount = otherDeck.filter { $0.isRed }.count
                OtherDeck(deck: otherDeck, redCount: rCount, blackCount: bCount)
                
                // other card
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        VStack {
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
                                Text("Exit")
                                    .font(.system(size: 20.ratioConstant))
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4.ratioConstant)
                            })
                            .background(Color.red)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            MainCard(cardImage: otherSelectedCard.isRed ? redCard : blackCard, isSelected: otherCardIsSelected)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("Win")
                                .font(.system(size: 32.ratioConstant))
                                .fontWeight(.black)
                                .foregroundColor(Color.yellow.opacity(1))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }
                
                // score
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text(pName)
                            .font(.system(size: 20.ratioConstant))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.ratioConstant)
                        Text(String(playerScore))
                            .font(.system(size: 36.ratioConstant))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    VStack(spacing: 0) {
                        Image(systemName: "chevron.up")
                            .font(.system(size: 28.ratioConstant, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Draw")
                            .font(.system(size: 32.ratioConstant))
                            .fontWeight(.black)
                            .foregroundColor(Color.yellow.opacity(1))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 28.ratioConstant, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    VStack(spacing: 0) {
                        Text(cName)
                            .font(.system(size: 20.ratioConstant))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 8.ratioConstant)
                        Text(String(computerScore))
                            .font(.system(size: 36.ratioConstant))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(16.ratioConstant)
                
                // my card
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        VStack {
                            Text("Win")
                                .font(.system(size: 32.ratioConstant))
                                .fontWeight(.black)
                                .foregroundColor(Color.yellow.opacity(1))
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            MainCard(cardImage: playerSelectedCard.value, isSelected: myCardIsSelected)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Button(action: {
                                play()
                            }, label: {
                                Text("Deal")
                                    .font(.system(size: 20.ratioConstant))
                                    .foregroundColor(Color.red)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4.ratioConstant)
                            })
                            .background(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }
                
                // my deck
                HStack {
                    MyDeck(deck: myDeck, clickable: playerCardClickable, user: user, selectedCard: $playerSelectedCard, isSelected: $myCardIsSelected)
                }
            }
        }
        .onAppear(perform: {
            if isServer {
                SocketIOManager.shared.listenForRoomInfo { roomInfo in
                    if user == nil {
                        if roomInfo.user2 == "" {
                            user = .user1
                            pName = roomInfo.user1
                            cName = "Wating..."
                            myDeck = user1Deck
                            otherDeck = user2Deck
                        } else {
                            user = .user2
                            pName = roomInfo.user2
                            cName = roomInfo.user1
                            myDeck = user2Deck
                            otherDeck = user1Deck
                        }
                    } else {
                        cName = roomInfo.user2
                    }
                }
                SocketIOManager.shared.listenForBWGameInfo { gameInfo in
                    let card = Card(rank: Card.Rank(rawValue: gameInfo.rank)!, suit: Card.Suit(rawInt: gameInfo.suit))
                    if gameInfo.user != user?.rawValue {
                        otherSelectedCard = card
                        otherCardIsSelected = true
                    }
                }
            } else {
                pName = playerName
                cName = "Computer"
                myDeck = user1Deck
                otherDeck = user2Deck
                
                reset()
            }
        })
    }
    
    private func play() {
        guard myDeck.contains(playerSelectedCard) else {
            print("카드를 선택해라~")
            return
        }
        
        playerCardClickable = false
        
        // check
        let computerRank = otherSelectedCard.rank.rawValue
        let playerRank = playerSelectedCard.rank.rawValue
        if playerRank > computerRank {
            playerScore += 1
        } else if playerRank < computerRank {
            computerScore += 1
        } else {
            playerScore += 0
            computerScore += 0
        }
        
        // pop card
        otherDeck = otherDeck.filter { $0.rank != otherSelectedCard.rank }
        myDeck = myDeck.filter { $0.rank != playerSelectedCard.rank }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            reset()
        }
    }
    
    private func reset() {
        myCardIsSelected = false
        otherCardIsSelected = false
        
        playerCardClickable = true
        
        computerSetup()
    }
    
    private func computerSetup() {
        let computerRand = Int.random(in: 0..<otherDeck.count)
        let computerCard = otherDeck[computerRand]
        otherSelectedCard = computerCard
        otherCardIsSelected = true
    }
}

struct BWGameView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            BWGameView(presented: .constant(true), playerName: "Player", isServer: false)
            BWGameView(presented: .constant(true), playerName: "Player", isServer: false)
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
