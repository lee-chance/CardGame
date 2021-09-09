//
//  MyDeck.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/25.
//

import SwiftUI

struct MyDeck: View {
    
    @Binding var deck: [Card]
    @Binding var selectedCard: Card
    @Binding var clickable: Bool
    
    var body: some View {
        HStack {
            ForEach(deck, id: \.self) { card in
                Button(action: {
                    print(card.value)
                    if clickable {
                        selectedCard = card
                    }
                }, label: {
                    Image(card.value)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 60.0.ratioConstant)
                })
            }
        }
    }
}

let user1Deck = [
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

struct MyDeck_Previews: PreviewProvider {
    static var previews: some View {
        MyDeck(deck: .constant(user1Deck), selectedCard: .constant(user1Deck[0]), clickable: .constant(true))
    }
}
