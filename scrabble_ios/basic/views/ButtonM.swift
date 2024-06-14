//
//  ButtonM.swift
//  scrabble_ios
//
//  Created by smgoncharov on 14.06.2024.
//

import SwiftUI

struct ButtonM: View {
    private let action: () -> Void
    private let text: String
    
    init(action: @escaping () -> Void, text: String) {
        self.action = action
        self.text = text
    }
    
    
    var body: some View {
        Text(text)
            .frame(width: UIScreen.main.bounds.size.width / 2)
            .padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
            .foregroundColor(.white)
            .font(.title3)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.black)
                        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    
                }
            }
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    ButtonM(action: {}, text: "Aboba")
}
