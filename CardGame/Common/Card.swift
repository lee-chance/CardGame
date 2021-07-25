//
//  File.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import Foundation

struct Card {
    enum Suit: Character {
        case spades = "♠︎", hearts = "♡", diamonds = "♢", clubs = "♣︎", back = "B", redBack = "R", blackBack = "b"
        
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
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, back, redBack, blackBack
        
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
        if rank == .redBack || suit == .redBack {
            return "redBack"
        }
        if rank == .blackBack || suit == .blackBack {
            return "blackBack"
        }
        return "\(rank.toString)\(suit.rawValue)"
    }
    
    var isBlack: Bool {
        if suit == .spades || suit == .clubs {
            return true
        }
        return false
    }
    
    var isRed: Bool {
        if suit == .hearts || suit == .diamonds {
            return true
        }
        return false
    }
}
