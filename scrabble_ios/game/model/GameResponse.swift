//
//  GameResponse.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation

struct GameUserResponse: Decodable {
    var id: String
    var name: String
}

struct GameResponse: Decodable {
    var availableTiles: String
    var desk: String
    var adminUserId: String
    var startTimer: Bool
    var tilesLeft: Int
    var currentTurnUserId: String
    var users: [GameUserResponse]
}
