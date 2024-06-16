//
//  RoomResponse.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import Foundation

struct RoomResponse: Decodable {
    var users: Array<UserResponse>
    var adminUserId: String
    var roomName: String
    var inviteCode: String?
    
    enum CodingKeys: String, CodingKey {
        case adminUserId = "admin_user_id"
        case users
        case roomName = "room_name"
        case inviteCode = "invite_code"
    }
}

struct UserResponse: Decodable {
    var id: String
    var name: String
}
