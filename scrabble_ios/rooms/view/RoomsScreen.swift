//
//  RoomsScreen.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct RoomsScreen: View {
    @ObservedObject var viewModel = RoomsViewModel()
    
    var body: some View {
        VStack {
            Text("Rooms")
                .bold()
                .font(.largeTitle)
            
            
            HStack {
                Text("Have a private code?")
                    .font(.title)
                    .bold()
                    .padding([.top], 15)
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
            ForEach(viewModel.rooms) { roomItem in
                RoomsItem(name: roomItem.name, action: {
                    
                }).padding([.leading, .trailing], 30)
            }
            Spacer()
        }
    }
}

#Preview {
    RoomsScreen()
}
