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
    private let buttonType: ButtonType
    private let width: CGFloat
    
    init(action: @escaping () -> Void, text: String, buttonType: ButtonType = .regular, width: CGFloat) {
        self.action = action
        self.text = text
        self.buttonType = buttonType
        self.width = width
    }
    
    
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
            .foregroundColor(.white)
            .font(.title3)
            .frame(width: self.width)
            .background {
                ZStack {
                    let color = switch(self.buttonType) {
                    case .negative:
                        UIColor(rgb: 0xA00000)
                    case .regular:
                        UIColor(.black)
                    }
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(color))
                        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    
                }
            }
            .onTapGesture {
                action()
            }
    }
    
    enum ButtonType {
        case regular, negative
    }
}

#Preview {
    ButtonM(action: {}, text: "Aboba", buttonType: .negative, width: 300)
}
