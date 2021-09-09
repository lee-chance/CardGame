//
//  TitleBar.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct TitleBar: View {
    
    @Binding var presented: Bool
    var title: String = "Title"
    
    var body: some View {
        HStack {
            Button(action: {
                presented = false
            }, label: {
                Text("X")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.pink)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            })
            Spacer()
            Text(title)
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("X")
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal)
    }
}
