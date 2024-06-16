//
//  RoomRequest.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import Foundation

struct RoomRequest: Encodable {
    var roomId: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
    }
}
