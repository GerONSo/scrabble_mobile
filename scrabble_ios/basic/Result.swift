//
//  Result.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(String)
}
