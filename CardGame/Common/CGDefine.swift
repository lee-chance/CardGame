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
    enum List: String, CaseIterable {
        case none
        case cardCompare
        case blackAndWhite
//        case indianHoldem
        
        var title: String {
            get {
                switch self {
                case .cardCompare: return "Card Compare"
                case .blackAndWhite: return "Black and White"
//                case .indianHoldem: return "Indian Holdem"
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
