//
//  RoomsScreen.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct RoomsScreen: View {
    @ObservedObject var viewModel = RoomsViewModel()
    @ObservedObject var mainViewModel: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        VStack {
            Text("Rooms")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top])
            
            CustomTabView(rooms: viewModel.rooms, viewModel: viewModel, mainViewModel: self.mainViewModel)
            Spacer()
            
        }
    }
}

//#Preview {
//    RoomsScreen()
//}
