//
//  scrabble_iosApp.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import SwiftUI

@main
struct scrabble_iosApp: App {
    @AppStorage("log_status") var log_status: Bool = false

    var body: some Scene {
        WindowGroup {
            if log_status {
                ContentView()
            } else {
                Auth()
            }
        }
    }
}
