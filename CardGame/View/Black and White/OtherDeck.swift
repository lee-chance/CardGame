//
//  OtherDeck.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/25.
//

import SwiftUI

struct OtherDeck: View {
    
    let deck: [Card]
    let redCount: Int
    let blackCount: Int
    
    var body: some View {
        HStack {
            let redCard = Image(Card.redBack().value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60.0.ratioConstant)
            let blackCard = Image(Card.blackBack().value)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60.0.ratioConstant)
            
            ForEach(0..<deck.count, id: \.self) { i in
                i % 2 == 0
                    ? redCount > i / 2
                        ? redCard
                        : blackCard
                    : blackCount > i / 2
                        ? blackCard
                        : redCard
            }
        }
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
        OtherDeck(deck: user2Deck, redCount: 5, blackCount: 5)
    }
}
