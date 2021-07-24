//
//  MySceneDelegate.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import UIKit

class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("connecting scene")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
        SocketIOManager.shared.closeConnection()
    }
}
