//
//  RoomItemView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import SwiftUI

struct UserItemView: View {
    private var UserItem: RoomItem
    
    init(roomItem: RoomItem) {
        self.roomItem = roomItem
    }
    
    var body: some View {
        Text(self.roomItem.name)
    }
}

#Preview {
    RoomItemView()
}
