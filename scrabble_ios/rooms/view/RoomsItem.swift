//
//  RoomsItem.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct RoomsItem: View {
    var name: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(self.name)
            Spacer()
            ButtonS(action: self.action, text: "Join")
        }
    }
}

#Preview {
    RoomsItem(name: "Room 1", action: {})
}
