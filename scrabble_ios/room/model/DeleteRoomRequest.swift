//
//  DeleteRoomRequest.swift
//  scrabble_ios
//
//  Created by smgoncharov on 17.06.2024.
//

import Foundation

struct DeleteRoomRequest: Encodable {
    var roomId: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
    }
}
