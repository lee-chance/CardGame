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
    
    enum State: String {
        case user1
        case user2
        case playing
        case wating
        case over
    }
}
