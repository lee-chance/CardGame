//
//  MainView.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/07/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var CCIsPresent = false
    @State private var IHIsPresent = false
    @State private var BWIsPresent = false
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            
            Background()
            
            mView()
                .frame(width: 320.ratioConstant, height: 320.ratioConstant)
            
            VStack {
                
                Text("Game List")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                
                // Card Compare
                Button(action: {
                    CCIsPresent = true
                }, label: {
                    Text("Card Compare")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $CCIsPresent, content: {
                    CCLobbyView(presented: $CCIsPresent)
                })
                
                
                // Indian Holdem
                Button(action: {
                    showingAlert = true
//                    IHIsPresent = true
                }, label: {
                    Text("Indian Holdem")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $IHIsPresent, content: {
                    IHLobbyView(presented: $IHIsPresent)
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Not yet open."), message: Text(""), dismissButton: .default(Text("Ok")))
                }
                
                
                // Black and White
                Button(action: {
                    BWIsPresent = true
                }, label: {
                    Text("Black and White")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                .padding()
                .fullScreenCover(isPresented: $BWIsPresent, content: {
                    BWLobbyView(presented: $BWIsPresent)
                })
            }
        }
    }
}

struct mView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
