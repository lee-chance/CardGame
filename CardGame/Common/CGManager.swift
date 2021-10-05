//
//  CGManager.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/10/05.
//

import Foundation

class CGManager {
    static let shared = CGManager()
    
    var gameType: Game.`Type` = .none
}
