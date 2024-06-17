//
//  ScoreItem.swift
//  scrabble_ios
//
//  Created by smgoncharov on 17.06.2024.
//

import Foundation

struct ScoreItem: Identifiable {
    var id = UUID()
    var name: String
    var score: String
}
