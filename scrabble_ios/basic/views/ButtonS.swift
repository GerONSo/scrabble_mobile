//
//  ButtonS.swift
//  scrabble_ios
//
//  Created by smgoncharov on 13.06.2024.
//

import SwiftUI

struct ButtonS: View {
    
    private let action: () -> Void
    private let text: String
    private let buttonType: ButtonType
    
    init(action: @escaping () -> Void, text: String, buttonType: ButtonType = .regular) {
        self.action = action
        self.text = text
        self.buttonType = buttonType
    }
    
    
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            .foregroundColor(.white)
            .font(.callout)
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
    ButtonS(action: {}, text: "Aboba", buttonType: .regular)
}
