//
//  RoomsInteractor.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation

class RoomsInteractor {
    func getRooms(resultCompletion: @escaping (Result<RoomsResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "GET", endpoint: "rooms/all", authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func join(userId: String, roomId: String?, inviteCode: String?, resultCompletion: @escaping (Result<JoinResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        let request = JoinRequest(userId: userId, roomId: roomId, inviteCode: inviteCode)
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/join", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func create(userId: String, roomName: String, isPrivate: Bool, resultCompletion: @escaping (Result<CreateRoomResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        let request = CreateRoomRequest(userId: userId, roomName: roomName, isPrivate: isPrivate)
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/create", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
}
