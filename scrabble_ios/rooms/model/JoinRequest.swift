//
//  JoinRequest.swift
//  scrabble_ios
//
//  Created by smgoncharov on 16.06.2024.
//

import Foundation

struct JoinRequest: Encodable {
    var userId: String
    var roomId: String?
    var inviteCode: String?
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case userId = "user_id"
        case inviteCode = "invite_code"
    }
}
