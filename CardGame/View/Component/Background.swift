//
//  Background.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct Background: View {
    var body: some View {
        // background Image
        Image("background")
            .resizable()
            .ignoresSafeArea()
        
        Color(.sRGB, white: 0.1, opacity: 0.5)
            .ignoresSafeArea()
    }
}
