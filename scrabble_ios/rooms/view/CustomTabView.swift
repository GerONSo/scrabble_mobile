//
//  TabView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct CustomTabView: View {
    @State var selected = Array<Bool>([true, false])
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
                VStack {
                    Text("Join")
                        .font(.title2)
                        .bold()
                        .onTapGesture {
                            selected[1] = false
                            selected[0] = true
                        }
                    VStack{
                        Color.black.frame(width: UIScreen.main.bounds.size.width / 2, height: 2)
                            .opacity(selected[0] ? 1 : 0)
                    }
                }
                VStack {
                    Text("Create")
                        .font(.title2)
                        .bold()
                        .onTapGesture {
                            selected[1] = true
                            selected[0] = false
                        }
                    VStack{
                        Color.black.frame(width: UIScreen.main.bounds.size.width / 2, height: 2)
                            .opacity(selected[1] ? 1 : 0)
                    }
                }
            }
            .padding([.top], 10)
            if (selected[0]) {
                JoinRoomsTab(rooms: self.rooms, viewModel: viewModel, mainViewModel: self.mainViewModel)
            } else {
                CreateRoomTab(roomsViewModel: viewModel, mainViewModel: mainViewModel)
            }
        }
    }
}

#Preview {
    CustomTabView(rooms: Array(), viewModel: RoomsViewModel(), mainViewModel: MainViewModel())
}
