//
//  BaseApi.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation

class BaseApi {
    private static let BASE_URL = "http://127.0.0.1:8080/"
    private static let encoder = JSONEncoder()
    
    static func makeRequest<T: Decodable>(httpMethod: String, endpoint: String, requestData: Encodable? = nil, authorizationToken: String, resultCompletion: @escaping (Result<T>) -> Void) {
        let url = URL(string: BASE_URL + endpoint)!
        Task {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer " + authorizationToken, forHTTPHeaderField: "Authorization")
            if (requestData != nil) {
                request.httpBody = try encoder.encode(requestData!)
            }
            do {
                let (data, _) = try await URLSession.shared.data(for: request)

                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    resultCompletion(.success(result))
                } else {
                    resultCompletion(.failure("Invalid Response"))
                }
            } catch {
                resultCompletion(.failure("Failed to Send POST Request \(error)"))
            }
        }
    }
}
