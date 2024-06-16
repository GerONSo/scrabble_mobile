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
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "rooms/get_users", requestData: request, authorizationToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4RDgwM0U1MS1CQTA3LTQ4OUYtOEQ4Ni04MUM1RjI5NTI1MDkifQ.PMVQBnBCwQNcH7IsevQpRruh64fC5ushST1WfPLFUxM", resultCompletion: resultCompletion)
    }
}
