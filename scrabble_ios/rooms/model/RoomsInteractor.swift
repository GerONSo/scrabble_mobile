//
//  RoomsInteractor.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation

class RoomsInteractor {
    func getRooms(resultCompletion: @escaping (Result<RoomsResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "GET", endpoint: "rooms/all", authorizationToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4RDgwM0U1MS1CQTA3LTQ4OUYtOEQ4Ni04MUM1RjI5NTI1MDkifQ.PMVQBnBCwQNcH7IsevQpRruh64fC5ushST1WfPLFUxM", resultCompletion: resultCompletion)
    }
}
