//
//  EditTextView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 13.06.2024.
//

import SwiftUI

struct EditTextView: View {
    private var text: Binding<String>
    private let placeholder: String
    
    init(placeholder: String, text: Binding<String>) {
        self.text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        TextField(placeholder, text: text)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    
                }
            }
        
    }
}

//#Preview {
//    EditTextView(placeholder: "XXX123")
//}
