//
//  JoinRoomsTab.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct JoinRoomsTab: View {
    
    private var rooms: Array<RoomItem>
    @ObservedObject var viewModel: RoomsViewModel
    @ObservedObject var mainViewModel: MainViewModel
    
    init(rooms: Array<RoomItem>, viewModel: RoomsViewModel, mainViewModel: MainViewModel) {
        self.rooms = rooms
        self.viewModel = viewModel
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Have a private code?")
                    .font(.title)
                    .bold()
                    .padding([.top])
                    .padding([.leading], 30)
                Spacer()
            }
            HStack {
                EditTextView(placeholder: "XXX123", text: $viewModel.inviteCodeText)
                    .padding([.leading], 25)
                ButtonS(action: {
                    let currentRoomId = UserDefaults.standard.string(forKey: "currentRoomId")
                    if (currentRoomId == nil) {
                        viewModel.join(roomId: nil, inviteCode: viewModel.inviteCodeText, switchTab: {
                            mainViewModel.selectedTab = 1
                        })
                    }
                }, text: "Join")
                .padding([.trailing], 30)
                .opacity(UserDefaults.standard.string(forKey: "currentRoomId") == nil ? 1 : 0.3)
            }
            HStack {
                Text("Or use public ones")
                    .font(.title)
                    .bold()
                    .padding([.top], 15)
                    .padding([.leading], 30)
                Spacer()
            }
            ForEach(rooms) { roomItem in
                RoomsItem(name: roomItem.name, action: {
                    let currentRoomId = UserDefaults.standard.string(forKey: "currentRoomId")
                    if (currentRoomId == nil) {
                        viewModel.join(roomId: roomItem.id, inviteCode: nil, switchTab: {
                            mainViewModel.selectedTab = 1
                        })
                    }
                })
                .padding([.leading, .trailing], 30)
                .opacity(UserDefaults.standard.string(forKey: "currentRoomId") == nil ? 1 : 0.3)
            }
        }
    }
}

#Preview {
    JoinRoomsTab(rooms: Array(), viewModel: RoomsViewModel(), mainViewModel: MainViewModel())
}
