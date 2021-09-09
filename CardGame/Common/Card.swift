//
//  File.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import Foundation

struct Card {
    
    let face: Face, rank: Rank, suit: Suit
    
    enum Face: Character {
        case front = "f"
        case redBack = "r"
        case blackBack = "b"
    }
    
    enum Suit: Character {
        case spades = "♠︎", hearts = "♡", diamonds = "♢", clubs = "♣︎", back = "b"
        
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
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
        case back = 0
        
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
}

extension Card {
    init(face: Face) {
        self.init(face: face, rank: .back, suit: .back)
    }
    
    init(rank: Rank, suit: Suit) {
        self.init(face: .front, rank: rank, suit: suit)
    }
}

extension Card {
    var value: String {
        switch face {
        case .front:
            return "\(rank.toString)\(suit.rawValue)"
        case .redBack:
            return "redBack"
        case .blackBack:
            return "blackBack"
        default:
            return "Back"
        }
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
