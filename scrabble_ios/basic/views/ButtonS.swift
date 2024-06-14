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
    
    init(action: @escaping () -> Void, text: String) {
        self.action = action
        self.text = text
    }
    
    
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            .foregroundColor(.white)
            .font(.callout)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.black)
                        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    
                }
            }
    }
}

#Preview {
    ButtonS(action: {}, text: "Aboba")
}
