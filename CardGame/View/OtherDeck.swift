//
//  OtherDeck.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/25.
//

import SwiftUI

struct OtherDeck: View {
    
    @Binding var deck: [Card]
    @Binding var redCount: Int
    @Binding var blackCount: Int
    
    private let redCard = Card.redBack().value
    private let blackCard = Card.blackBack().value
    
    
    var body: some View {
        HStack {
            ForEach(0..<deck.count / 2) { i in
                if redCount > i {
                    Image(redCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 60.0.ratioConstant)
                }
                if blackCount > i {
                    Image(blackCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 60.0.ratioConstant)
                }
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
        OtherDeck(deck: .constant(user2Deck), redCount: .constant(5), blackCount: .constant(5))
    }
}
