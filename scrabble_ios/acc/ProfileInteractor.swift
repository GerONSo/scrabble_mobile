//
//  ProfileInteractor.swift
//  scrabble_ios
//
//  Created by smgoncharov on 17.06.2024.
//

import Foundation
import SwiftUI
class ProfileInteractor {
    func deleteUser(requestData: Encodable?, resultCompletion: @escaping (Result<DefaultResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "DELETE", endpoint: "deleteUser", requestData: requestData, authorizationToken: UserDefaults.standard.string(forKey: "jwtUser"), resultCompletion: resultCompletion)
    }
}
