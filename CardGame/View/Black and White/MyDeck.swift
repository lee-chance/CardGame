//
//  MyDeck.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/25.
//

import SwiftUI

struct MyDeck: View {
    
    let deck: [Card]
    let clickable: Bool
    let user: CGDefine.User?
    
    @Binding var selectedCard: Card
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            ForEach(deck, id: \.self) { card in
                Button(action: {
                    if clickable {
                        selectedCard = card
                        isSelected = true
                        if let user = user {
                            SocketIOManager.shared.deal(user: user, card: card)
                        }
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
        MyDeck(deck: user1Deck, clickable: true, user: .user1, selectedCard: .constant(user1Deck[0]), isSelected: .constant(true))
    }
}
