//
//  RoomItemView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import SwiftUI

struct UserItemView: View {
    private var userItem: UserItem
    private var adminUserId: String
    private let userId: String
    private let kickAction: () -> Void
    private let giveAdminAction: () -> Void
    
    @State private var wasClicked = false
    
    init(userItem: UserItem, adminUserId: String, kickAction: @escaping () -> Void, giveAdminAction: @escaping () -> Void) {
        self.userItem = userItem
        self.adminUserId = adminUserId
        self.userId = UserDefaults.standard.string(forKey: "userid")!
        self.kickAction = kickAction
        self.giveAdminAction = giveAdminAction
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(self.userItem.name)
                Spacer()
                if (self.userId != self.adminUserId && userItem.description == "admin") {
                    Text(self.userItem.description)
                        .fontWeight(.thin)
                } else if (self.userId == self.adminUserId) {
                    Text(self.userItem.description)
                        .fontWeight(.thin)
                        .onTapGesture {
                            wasClicked = !wasClicked
                        }
                }
            }.padding([.horizontal], 30)
            if (wasClicked && self.userItem.description != "admin" && self.userId == self.adminUserId) {
                HStack {
                    Spacer()
                    ButtonS(action: {
                        giveAdminAction()
                    }, text: "Give admin", buttonType: .regular)
                    .padding([.trailing], 15)
                    
                    ButtonS(action: {
                        kickAction()
                    }, text: "Kick", buttonType: .negative)
                    .padding([.trailing], 25)
                }
            }
        }
    }
}

//#Preview {
//    UserItemView(userItem: UserItem(id: UUID().uuidString, name: "username", description: "admin"), adminUserId: "")
//}
