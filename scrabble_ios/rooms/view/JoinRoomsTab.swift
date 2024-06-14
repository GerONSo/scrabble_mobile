//
//  JoinRoomsTab.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct JoinRoomsTab: View {
    
    private var rooms: Array<RoomItem>
    
    init(rooms: Array<RoomItem>) {
        self.rooms = rooms
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
                EditTextView(placeholder: "XXX123")
                    .padding([.leading], 25)
                ButtonS(action: {
                    // TODO private join
                }, text: "Join").padding([.trailing], 30)
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
                    
                }).padding([.leading, .trailing], 30)
            }
        }
    }
}

#Preview {
    JoinRoomsTab(rooms: Array())
}
