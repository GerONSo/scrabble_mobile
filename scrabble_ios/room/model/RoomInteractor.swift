//
//  RoomInteractor.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import Foundation

class RoomInteractor {
    func getRoom(roomId: String, resultCompletion: @escaping (Result<RoomResponse>) -> Void) {
        let request = RoomRequest(roomId: roomId)
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/get_users", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func leave(roomId: String, userId: String, resultCompletion: @escaping (Result<DefaultResponse>) -> Void) {
        let request = LeaveRequest(userId: userId, roomId: roomId)
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/kick", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
}
