//
//  JoinResponse.swift
//  scrabble_ios
//
//  Created by smgoncharov on 16.06.2024.
//

import Foundation

struct JoinResponse: Decodable {
    var roomId: String?
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
    }
}
