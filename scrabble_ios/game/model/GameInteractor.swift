//
//  GameInteractor.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation

class GameInteractor {
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
    
    func getScoreBoard(roomId: String, resultCompletion: @escaping (Result<ScoreModelResponse>) -> Void) {
        let jwtToken = UserDefaults.standard.string(forKey: "jwtUser")!
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/scoreboard", requestData: ScoreRequest(roomId: roomId), authorizationToken: jwtToken, resultCompletion: resultCompletion)
    }
}
