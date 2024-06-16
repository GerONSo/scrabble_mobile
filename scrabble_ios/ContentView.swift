//
//  ContentView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("Rooms")
                .tabItem {
                    Text("Rooms")
                    Image(systemName: "house")
                        .renderingMode(.template)
                }
            
            /*RoomScreen(roomId: "93806E20-3703-4CE3-83A9-02F9C07A994D")
                .tabItem {
                    Text("Game")
                    Image(systemName: "gamecontroller")
                        .renderingMode(.template)
                }
                .padding([.bottom], 20)*/
            GameView()
                .tabItem {
                    Text("Game")
                    Image(systemName: "gamecontroller")
                        .renderingMode(.template)
                }
                .padding([.bottom], 20)
            
            Text("Account")
                .tabItem {
                    Text("Account")
                    Image(systemName: "person.crop.circle")
                        .renderingMode(.template)
                }
            
        }.tint(.black)
    }
}

#Preview {
    ContentView()
}
