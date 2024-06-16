//
//  CreateRoomTab.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct CreateRoomTab: View {
    @State private var isOn: Bool = false
    
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
            EditTextView(placeholder: "Some name")
                .padding([.leading, .trailing], 25)
            HStack {
                Toggle(isOn: self.$isOn) {
                    Text("Make private")
                        .font(.title)
                        .bold()
                }
                .tint(.black)
                .padding([.top], 15)
                .padding([.leading, .trailing], 30)
            }
            ButtonM(action: {
                
            }, text: "Create", width: UIScreen.main.bounds.size.width / 2)
            .padding([.top], 40)
        }
    }
}

#Preview {
    CreateRoomTab()
}
