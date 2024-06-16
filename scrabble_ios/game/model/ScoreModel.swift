//
//  ScoreModel.swift
//  scrabble_ios
//
//  Created by Максим Троицкий on 17.06.2024.
//

import Foundation

struct ScoreModelResponse: Decodable {
    var scores: Array<ScoreModel>
}

struct ScoreModel: Decodable, Hashable {
    var name: String
    var score: String
}

struct ScoreRequest: Encodable {
    var roomId: String
}
