//
//  ContentView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            RoomsScreen(mainViewModel: viewModel)
                .tabItem {
                    Text("Rooms")
                    Image(systemName: "house")
                        .renderingMode(.template)
                }
                .tag(0)
            
            /*RoomScreen(roomId: UserDefaults.standard.string(forKey: "currentRoomId"), mainViewModel: self.viewModel)
                .tabItem {
                    Text("Game")
                    Image(systemName: "gamecontroller")
                        .renderingMode(.template)
                }
                .padding([.bottom], 20)
                .tag(1)*/
            GameView()
                .tabItem {
                    Text("Game")
                    Image(systemName: "gamecontroller")
                        .renderingMode(.template)
                }
                .padding([.bottom], 20)
                .tag(1)
            
            Text("Account")
                .tabItem {
                    Text("Account")
                    Image(systemName: "person.crop.circle")
                        .renderingMode(.template)
                }
                .tag(2)
            
        }.tint(.black)
    }
}

#Preview {
    ContentView()
}
