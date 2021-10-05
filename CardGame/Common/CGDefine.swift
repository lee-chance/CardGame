//
//  CGDefine.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/09/10.
//

import Foundation

struct CGDefine {
    enum User: String {
        case user1
        case user2
    }
}

struct Game {
    enum `Type`: String {
        case none
        case cardCompare
        case indianHoldem
        case blackAndWhite
        
        var title: String {
            get {
                switch self {
                case .cardCompare: return "Card Compare"
                case .indianHoldem: return "Indian Holdem"
                case .blackAndWhite: return "Black And White"
                default: return "none"
                }
            }
        }
    }
    
    enum State: String {
        case user1
        case user2
        case playing
        case wating
        case over
    }
}
