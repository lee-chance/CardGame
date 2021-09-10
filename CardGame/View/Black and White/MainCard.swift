//
//  MainCard.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/09/10.
//

import SwiftUI

struct MainCard: View {
    
    let cardImage: String
    let isSelected: Bool
    
    var body: some View {
        Image(cardImage)
            .resizable()
            .scaledToFit()
            .opacity(isSelected ? 1 : 0)
            .frame(width: 80.0.ratioConstant)
            .overlay(
                Rectangle().stroke(Color.white, lineWidth: 2)
                    .padding(-10.ratioConstant)
            )
    }
}

struct MainCard_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MainCard(cardImage: Card.redBack().value, isSelected: true)
        }
    }
}
