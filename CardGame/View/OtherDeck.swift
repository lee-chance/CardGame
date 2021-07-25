//
//  OtherDeck.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/25.
//

import SwiftUI

struct OtherDeck: View {
    
    @Binding var deck: [Card]
    
    private let redCard = Card(rank: .redBack, suit: .redBack).value
    private let blackCard = Card(rank: .blackBack, suit: .blackBack).value
    
    var body: some View {
        HStack {
            ForEach(0..<deck.count / 2) { i in
                Image(redCard)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(blackCard)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                switch (i % 2) {
//                case 0:
//                    if cardCount.redCount > 0 {
//                        Image(redCard)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear(perform: {
//                                print("1 - \(cardCount.redCount)")
//                                cardCount.redCount -= 1
//                            })
//                    } else {
//                        Image(blackCard)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear(perform: {
//                                print("2 - \(cardCount.blackCount)")
//                                cardCount.blackCount -= 1
//                            })
//                    }
//                case 1:
//                    if cardCount.blackCount > 0 {
//                        Image(blackCard)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear(perform: {
//                                print("3 - \(cardCount.blackCount)")
//                                cardCount.blackCount -= 1
//                            })
//                    } else {
//                        Image(redCard)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onAppear(perform: {
//                                print("4 - \(cardCount.redCount)")
//                                cardCount.redCount -= 1
//                            })
//                    }
//                default:
//                    Image(redCard)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                }
            }
        }
//        .onAppear(perform: {
//            cardCount = CardCount(deck: deck)
//        })
    }
    
    private func count() {
        print("*** \(deck.count)")
        var bCount = 0
        var rCount = 0
        for card in deck {
            if card.isBlack {
                bCount += 1
            } else {
                rCount += 1
            }
        }
//        cardCount.redCount = rCount
//        cardCount.blackCount = bCount
//        blackCount = bCount
//        redCount = rCount
    }
    
}

let user2Deck = [
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

struct OtherDeck_Previews: PreviewProvider {
    static var previews: some View {
        OtherDeck(deck: .constant(user2Deck))
    }
}
