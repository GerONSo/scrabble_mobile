//
//  ContentView.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = RoomsViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
