//
//  RoomsResponse.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation

struct RoomsResponse: Decodable {
    var rooms: Array<RoomItemResponse>
}

struct RoomItemResponse: Decodable {
    var id: String
    var name: String
}
