//
//  CreateRoomRequest.swift
//  scrabble_ios
//
//  Created by smgoncharov on 16.06.2024.
//

import Foundation

struct CreateRoomRequest: Encodable {
    var userId: String
    var roomName: String
    var isPrivate: Bool
}
