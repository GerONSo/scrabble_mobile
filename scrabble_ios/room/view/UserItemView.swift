//
//  RoomItemView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import SwiftUI

struct UserItemView: View {
    private var userItem: UserItem
    
    @State private var wasClicked = false
    
    init(userItem: UserItem) {
        self.userItem = userItem
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(self.userItem.name)
                Spacer()
                Text(self.userItem.description)
                    .fontWeight(.thin)
                    .onTapGesture {
                        wasClicked = !wasClicked
                    }
            }.padding([.horizontal], 30)
            if (wasClicked && self.userItem.description != "admin") {
                HStack {
                    Spacer()
                    ButtonS(action: {
                        
                    }, text: "Kick", buttonType: .negative)
                    .padding([.trailing], 25)
                }
            }
        }
    }
}

#Preview {
    UserItemView(userItem: UserItem(id: UUID().uuidString, name: "username", description: "admin"))
}
