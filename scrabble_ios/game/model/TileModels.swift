//
//  TileModels.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 16.06.2024.
//

import Foundation

struct BoardTile {
    var letter: String?
    var multiplier: MultiplierType
    
    enum MultiplierType: Codable {
        case empty, TW, DW, DL, TL
    }
}

struct LetterTile: Identifiable, Codable {
    let id: UUID
    let letter: String
    let value: Int
}
