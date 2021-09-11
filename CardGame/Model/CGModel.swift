//
//  CGModel.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/09/11.
//

import Foundation

struct RoomInfo: Codable {
    let isFull: Bool
    let user1: String
    let user2: String
}

protocol GameInfo: Codable {}

// for card compare
struct CCGameInfo: GameInfo {
    let user1SuitRandom: Int
    let user1RankRandom: Int
    let user2SuitRandom: Int
    let user2RankRandom: Int
}

// for black and white
struct BWGameInfo: GameInfo {
    let type: String?
    let user: String?
    let rank: Int?
    let suit: Int?
    let result: String?
}
