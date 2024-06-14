//
//  RoomsScreen.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct RoomsScreen: View {
    @ObservedObject var viewModel = RoomsViewModel()
    
    var body: some View {
        VStack {
            Text("Rooms")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top])
            
            TabView(rooms: viewModel.rooms)
            Spacer()
            
        }
    }
}

#Preview {
    RoomsScreen()
}
