//
//  MyAppDelegate.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import UIKit

class MyAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
//        SocketIOManager.shared.establishConnection()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "My Scene Delegate", sessionRole: connectingSceneSession.role)
        config.delegateClass = MySceneDelegate.self
        return config
    }
}
