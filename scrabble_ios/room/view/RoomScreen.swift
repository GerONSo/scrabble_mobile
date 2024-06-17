//
//  RoomScreen.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import SwiftUI

struct RoomScreen: View {
    @ObservedObject var viewModel: RoomViewModel
    @ObservedObject var mainViewModel: MainViewModel
    private var roomId: String?
    @State var gameStarted: Bool = false
    
    init(roomId: String?, mainViewModel: MainViewModel) {
        self.viewModel = RoomViewModel(roomId: roomId)
        self.mainViewModel = mainViewModel
        self.roomId = roomId
    }
    
    var body: some View {
        if (!gameStarted) {
            if (roomId != nil) {
                VStack {
                    Text(viewModel.roomName)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding([.top])
                    VStack {
                        ForEach($viewModel.users) { $userItem in
                            UserItemView(userItem: userItem, adminUserId: $viewModel.adminUserId.wrappedValue, kickAction: {
                                viewModel.kick(kickUserId: userItem.id)
                            }, giveAdminAction: {
                                viewModel.giveAdmin(userId: userItem.id)
                            })
                            .padding([.top], 15)
                        }
                    }.padding([.top], 20)
                    Spacer()
                    if (viewModel.adminUserId == UserDefaults.standard.string(forKey: "userid")!) {
                        ButtonM(action: {
                            gameStarted = true
                        }, text: "Start game", buttonType: .negative, width: 170).padding([.leading], 30)
                    }
                    HStack {
                        let userId = UserDefaults.standard.string(forKey: "userid")!
                        if (viewModel.adminUserId == userId) {
                            ButtonM(action: {
                                viewModel.deleteRoom {
                                    mainViewModel.selectedTab = 0
                                }
                            }, text: "Delete room", buttonType: .negative, width: 170).padding([.leading], 30)
                        }
                        Spacer()
                        ButtonM(action: {
                            viewModel.leaveRoom {
                                mainViewModel.selectedTab = 0
                            }
                        }, text: "Leave", buttonType: .regular, width: 170).padding([.trailing], 30)
                    }
                }
            } else {
                Text("No active game\n\nJoin any of existing\nor create your own")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top])
            }
        } else {
            GameView()
        }
    }
}

#Preview {
    RoomScreen(roomId: "93806E20-3703-4CE3-83A9-02F9C07A994D", mainViewModel: MainViewModel())
}
