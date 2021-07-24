//
//  File.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import Foundation

struct Card {
    enum Suit: Character {
        case spades = "♠︎", hearts = "♡", diamonds = "♢", clubs = "♣︎", back = "B"
        
        var rawInt: Int {
            switch self {
            case .spades: return 3
            case .hearts: return 2
            case .diamonds: return 1
            case .clubs: return 0
            default: return -1
            }
        }
    }
    
    enum Rank: Int {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, back
        
        var toString: String {
            switch self {
            case .ace: return "A"
            case .jack: return "J"
            case .queen: return "Q"
            case .king: return "K"
            default: return "\(self.rawValue)"
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var value: String {
        if rank == .back || suit == .back {
            return "Back"
        }
        return "\(rank.toString)\(suit.rawValue)"
    }
}
