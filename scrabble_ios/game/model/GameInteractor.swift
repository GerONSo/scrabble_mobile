//
//  GameInteractor.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation

class GameInteractor {
    /*func auth(requestData: Encodable?, resultCompletion: @escaping (Result<RegistrationResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "register", requestData: requestData, authorizationToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4RDgwM0U1MS1CQTA3LTQ4OUYtOEQ4Ni04MUM1RjI5NTI1MDkifQ.PMVQBnBCwQNcH7IsevQpRruh64fC5ushST1WfPLFUxM", resultCompletion: resultCompletion)
    }
     
    func getRooms(resultCompletion: @escaping (Result<RoomsResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "GET", endpoint: "rooms/all",authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func join(userId: String, roomId: String?, inviteCode: String?, resultCompletion:@escaping (Result<DefaultResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        let request = JoinRequest(userId: userId, roomId: roomId, inviteCode: inviteCode)
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/join", requestData:request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func create(userId: String, roomName: String, isPrivate: Bool, resultCompletion:@escaping (Result<CreateRoomResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        let request = CreateRoomRequest(userId: userId, roomName: roomName, isPrivate:isPrivate)
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/create", requestData:request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }*/
    
    func startGame(roomId: String, userId: String, resultCompletion: @escaping (Result<DefaultResponse>) -> Void) {
        let request = LeaveRequest(userId: userId, roomId: roomId)
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/start", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func pauseGame(roomId: String, userId: String, resultCompletion: @escaping (Result<DefaultResponse>) -> Void) {
        let request = LeaveRequest(userId: userId, roomId: roomId)
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/pause", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
    
    func unpauseGame(roomId: String, userId: String, resultCompletion: @escaping (Result<DefaultResponse>) -> Void) {
        let request = LeaveRequest(userId: userId, roomId: roomId)
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/unpause", requestData: request, authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
}
