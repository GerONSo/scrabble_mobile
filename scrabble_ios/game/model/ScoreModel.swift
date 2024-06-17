//
//  ScoreModel.swift
//  scrabble_ios
//
//  Created by Максим Троицкий on 17.06.2024.
//

import Foundation

struct ScoreModelResponse: Decodable {
    var scoreboard: Array<ScoreModel>
}

struct ScoreModel: Decodable {
    var name: String
    var score: String
}

struct ScoreRequest: Encodable {
    var roomId: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
    }
}
