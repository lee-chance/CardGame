//
//  SocketIOManager.swift
//  SocketIOTutorial
//
//  Created by Changsu Lee on 2021/03/30.
//

import UIKit
import SocketIO

// step 0 - info.plist의 App Transport Security Settings/Allow Arbitrary Loads를 YES로 설정

// step 1 - SocketIOManager 클래스 작성
class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    // 9000번 포트사용
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var roomInfo: RoomInfo?
    var gameInfo: GameInfo?
    
    override init() {
        super.init()
        // test룸 생성
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Connected")
//            self?.socket.emit("NodeJS Server Port", "Hi Node.JS server!")
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func enter(room: String, nickname: String) {
        socket.emit("enter room", ["room": room, "nickname": nickname])
    }
    
    func leave(room: String, nickname: String) {
        socket.emit("leave room", ["room": room, "nickname": nickname])
    }
    
    func deal(room: String) {
        socket.emit("deal", ["room": room])
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
    
    func listenForGameInfo(handler: @escaping (_ info: GameInfo)->Void) {
        socket.on("game info") { [weak self] (data, ack) in
            do {
                let gameInfoData = data.first!
                let json = try JSONSerialization.data(withJSONObject: gameInfoData, options: .prettyPrinted)
                let result = try JSONDecoder().decode(GameInfo.self, from: json)
                self?.gameInfo = result
                print("data: \(result)")
                handler(result)
            } catch {
                print("failure")
            }
        }
    }
    
}

struct RoomInfo: Codable {
    let isFull: Bool
    let user: [String]
}

struct GameInfo: Codable {
    let user1SuitRandom: Int
    let user1RankRandom: Int
    let user2SuitRandom: Int
    let user2RankRandom: Int
}
