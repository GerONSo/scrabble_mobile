//
//  PlayerModel.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation

struct PlayerModel {
    public var isAdmin: Bool
    
    init(isAdmin: Bool) {
        self.isAdmin = isAdmin
    }
}
