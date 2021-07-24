//
//  CardGameApp.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

@main
struct CardGameApp: App {
    
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active: print("active")
            case .inactive: print("inactive")
            case .background: print("background")
            default: print("error!")
            }
        }
    }
}
