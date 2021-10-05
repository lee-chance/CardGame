//
//  BWGameView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct BWGameView: View {
    
    @Binding var presented: Bool
    let playerName: String
    let isServer: Bool
    
    @State private var user: CGDefine.User?
    @State private var turn: CGDefine.User = .user1
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
    
    @State private var gameState: CGDefine.State = .wating
    @State private var showWinWhenIWin: Bool = false
    @State private var showWinWhenILost: Bool = false
    @State private var centerText: String = "Wating..."
    @State private var isGameOver: Bool = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 10
    @State private var isTimerActive: Bool = false
    
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
                                exit()
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
                                .foregroundColor(Color.yellow.opacity(showWinWhenILost ? 1 : 0))
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
                            .foregroundColor(.white.opacity(turn != user ? 1 : 0))
                        Spacer()
                        Text(centerText)
                            .font(.system(size: 32.ratioConstant))
                            .fontWeight(.black)
                            .foregroundColor(Color.yellow.opacity(1))
                            // adjustsFontSizeToFitWidth
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            // adjustsFontSizeToFitWidth
                            .onReceive(timer) { _ in
                                guard isTimerActive else { return }
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                    centerText = "\(timeRemaining)"
                                } else {
                                    gameOver()
                                }
                            }
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 28.ratioConstant, weight: .bold))
                            .foregroundColor(.white.opacity(turn == user ? 1 : 0))
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
                                .foregroundColor(Color.yellow.opacity(user?.rawValue == gameState.rawValue ? 1 : 0))
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
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("(승리)"), message: Text("게임을 다시 하시겠습니까?"), primaryButton: .cancel(Text("아니요"), action: {
                exit()
            }), secondaryButton: .default(Text("예"), action: {
                isGameOver = false
            }))
        }
        .onAppear(perform: {
            if isServer {
                // FIXME: 정비 필요
                SocketIOManager.shared.listenForRoomInfo { roomInfo in
                    turn = .user1
                    if user == nil {
                        if roomInfo.user2 == "" {
                            user = .user1
                            pName = roomInfo.user1
                            cName = "Wating..."
                            myDeck = user1Deck
                            otherDeck = user2Deck
                            centerText = "Wating..."
                        } else {
                            user = .user2
                            pName = roomInfo.user2
                            cName = roomInfo.user1
                            myDeck = user2Deck
                            otherDeck = user1Deck
                            checkTurn()
                            countDown()
                        }
                    } else {
                        user = .user1
                        cName = roomInfo.user2
                        checkTurn()
                        countDown()
                    }
                }
                
                SocketIOManager.shared.listenForBWGameInfo { gameInfo in
                    switch gameInfo.type {
                    case "select card":
                        let card = Card(rank: Card.Rank(rawValue: gameInfo.rank!)!, suit: Card.Suit(rawInt: gameInfo.suit!))
                        if gameInfo.user != user?.rawValue {
                            otherSelectedCard = card
                            otherCardIsSelected = true
                        }
                    case "next turn":
                        turn = CGDefine.User(rawValue: gameInfo.result!)!
                        checkTurn()
                        countDown()
                    case "deal":
                        switch gameInfo.winner {
                        case "user1", "user2":
                            gameInfo.user == user?.rawValue
                                ? iWin()
                                : iLost()
//                            if gameInfo.user == user?.rawValue {
//                                iWin()
//                            } else {
//                                iLost()
//                            }
//                        case "user2":
//                            if gameInfo.user == user?.rawValue {
//                                iWin()
//                            } else {
//                                iLost()
//                            }
                        case "draw":
                            centerText = "Draw"
                        default: break
                        }
                        
                        turn = CGDefine.User(rawValue: gameInfo.result!)!
                        turnOver()
                        
                    default: break
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
        
        if otherDeck.contains(otherSelectedCard) {
            // check
            let otherRank = otherSelectedCard.rank.rawValue
            let playerRank = playerSelectedCard.rank.rawValue
            if isServer {
                SocketIOManager.shared.deal(user: user!, turn: turn, playerRank, otherRank)
            } else {
                if playerRank > otherRank {
                    iWin()
                } else if playerRank < otherRank {
                    iLost()
                } else {
                    centerText = "Draw"
                }
                turnOver()
            }
        } else {
            // 상대방이 아직 선택하지 않았으면 턴 넘기기
            SocketIOManager.shared.nextTurn(turn: turn)
        }
    }
    
    private func iWin() {
        centerText = ""
        playerScore += 1
        showWinWhenIWin = true
    }
    
    private func iLost() {
        centerText = ""
        computerScore += 1
        showWinWhenILost = true
    }
    
    private func turnOver() {
        checkTurn()
        isTimerActive = false
        
        // pop card
        otherDeck = otherDeck.filter { $0.rank != otherSelectedCard.rank }
        myDeck = myDeck.filter { $0.rank != playerSelectedCard.rank }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            reset()
        }
    }
    
    private func reset() {
        guard otherDeck.count > 0 else {
            gameOver()
            return
        }
        
        myCardIsSelected = false
        otherCardIsSelected = false
        showWinWhenIWin = false
        showWinWhenILost = false
        
        countDown()
        
        if !isServer {
            computerSetup()
        }
    }
    
    private func computerSetup() {
        let computerRand = Int.random(in: 0..<otherDeck.count)
        let computerCard = otherDeck[computerRand]
        otherSelectedCard = computerCard
        otherCardIsSelected = true
    }
    
    private func checkTurn() {
        playerCardClickable = user == turn
    }
    
    private func countDown() {
        isTimerActive = true
        timeRemaining = 10
    }
    
    private func gameOver() {
        isTimerActive = false
        isGameOver = true
    }
    
    private func exit() {
        presented = false
        if isServer {
            if user == .user1 {
                SocketIOManager.shared.leave(user: "U1")
            } else {
                SocketIOManager.shared.leave(user: "U2")
            }
        }
        SocketIOManager.shared.offListeners()
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
