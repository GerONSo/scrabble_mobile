//
//  RoomScreen.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import SwiftUI

struct RoomScreen: View {
    @ObservedObject var viewModel: RoomViewModel
    
    init(roomId: String) {
        self.viewModel = RoomViewModel(roomId: roomId)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.roomName)
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top])
            VStack {
                ForEach(viewModel.users) { userItem in
                    UserItemView(userItem: userItem)
                        .padding([.top], 15)
                }
            }.padding([.top], 20)
            Spacer()
            HStack {
                ButtonM(action: {
                    
                }, text: "Delete room", buttonType: .negative, width: 170).padding([.leading], 30)
                Spacer()
                ButtonM(action: {
                    
                }, text: "Leave", buttonType: .regular, width: 170).padding([.trailing], 30)
            }
        }
    }
}

#Preview {
    RoomScreen(roomId: "93806E20-3703-4CE3-83A9-02F9C07A994D")
}