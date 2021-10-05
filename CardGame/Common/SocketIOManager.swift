//
//  SocketIOManager.swift
//  SocketIOTutorial
//
//  Created by Changsu Lee on 2021/03/30.
//

import UIKit
import SocketIO

let BASE_URL = "http://localhost:9000"
//let BASE_URL = "http://172.30.1.19:9000"

// step 0 - info.plist의 App Transport Security Settings/Allow Arbitrary Loads를 YES로 설정

// step 1 - SocketIOManager 클래스 작성
class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    // 9000번 포트사용
    var manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var roomInfo: RoomInfo?
    var gameInfo: GameInfo?
    
//    override init() {
//        super.init()
//        socket = manager.defaultSocket
        
//        socket.on(clientEvent: .connect) { (data, ack) in
//            print("Connected")
//        }
//    }
    
    func establishConnection(namespace: String) {
        socket = manager.socket(forNamespace: namespace)
        socket.connect()
    }
    
    func closeConnection() {
        guard let socket = socket else { return }
        socket.disconnect()
    }
    
    func enter(nickname: String) {
        socket.emit("enter room", ["nickname": nickname])
    }
    
    func leave(user: String) {
        socket.emit("leave room", ["user": user])
    }
    
    func deal() {
        socket.emit("deal")
    }
    
    // for black and white
    func selectCard(user: CGDefine.User, card: Card) {
        socket.emit("select card", ["user": user.rawValue, "suit": card.suit.rawInt, "rank": card.rank.rawValue])
    }
    
    func deal(user: CGDefine.User, turn: CGDefine.User, _ pRank: Int, _ oRank: Int) {
        socket.emit("deal", ["user": user.rawValue, "turn": turn.rawValue, "player": pRank, "other": oRank])
    }
    
    func nextTurn(turn: CGDefine.User) {
        socket.emit("next turn", ["turn": turn.rawValue])
    }
    
    func listenForRoomInfo(handler: @escaping (_ info: RoomInfo)->Void) {
        socket.on("room info") { [weak self] (data, ack) in
            do {
                let roomInfoData = data.first!
                let json = try JSONSerialization.data(withJSONObject: roomInfoData, options: .prettyPrinted)
                let result = try JSONDecoder().decode(RoomInfo.self, from: json)
                self?.roomInfo = result
                print("data: \(result)")
                handler(result)
            } catch {
                print("failure")
            }
        }
    }
    
    // for card compare
    func listenForCCGameInfo(handler: @escaping (_ info: CCGameInfo)->Void) {
        socket.on("game info") { [weak self] (data, ack) in
            do {
                let gameInfoData = data.first!
                let json = try JSONSerialization.data(withJSONObject: gameInfoData, options: .prettyPrinted)
                let result = try JSONDecoder().decode(CCGameInfo.self, from: json)
                self?.gameInfo = result
                print("data: \(result)")
                handler(result)
            } catch {
                print("failure")
            }
        }
    }
    
    // for black and white
    func listenForBWGameInfo(handler: @escaping (_ info: BWGameInfo)->Void) {
        socket.on("game info") { [weak self] (data, ack) in
            do {
                let gameInfoData = data.first!
                let json = try JSONSerialization.data(withJSONObject: gameInfoData, options: .prettyPrinted)
                let result = try JSONDecoder().decode(BWGameInfo.self, from: json)
                self?.gameInfo = result
                print("data: \(result)")
                handler(result)
            } catch {
                print("failure")
            }
        }
    }
    
    func offListeners() {
        socket.off("room info")
        socket.off("game info")
    }
    
}
