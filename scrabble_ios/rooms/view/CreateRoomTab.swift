//
//  CreateRoomTab.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct CreateRoomTab: View {
    @ObservedObject var viewModel: RoomsViewModel
    @ObservedObject var mainViewModel: MainViewModel
    
    init(roomsViewModel: RoomsViewModel, mainViewModel: MainViewModel) {
        self.viewModel = roomsViewModel
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Name it")
                    .font(.title)
                    .bold()
                    .padding([.top])
                    .padding([.leading], 30)
                Spacer()
            }
            EditTextView(placeholder: "Some name", text: $viewModel.createRoomNameText)
                .padding([.leading, .trailing], 25)
            HStack {
                Toggle(isOn: $viewModel.isOn) {
                    Text("Make private")
                        .font(.title)
                        .bold()
                }
                .tint(.black)
                .padding([.top], 15)
                .padding([.leading, .trailing], 30)
            }
            ButtonM(action: {
                viewModel.create {
                    mainViewModel.selectedTab = 1
                }
            }, text: "Create", width: UIScreen.main.bounds.size.width / 2)
            .padding([.top], 40)
        }
    }
}

#Preview {
    CreateRoomTab(roomsViewModel: RoomsViewModel(), mainViewModel: MainViewModel())
}
