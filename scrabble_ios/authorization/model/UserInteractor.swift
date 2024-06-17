import Foundation

class UserInteractor {
    func auth(requestData: Encodable?, resultCompletion: @escaping (Result<RegistrationResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "register", requestData: requestData, resultCompletion: resultCompletion)
    }
    
    func login(requestData: Encodable?, resultCompletion: @escaping (Result<LoginResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "login", requestData: requestData, resultCompletion: resultCompletion)
    }
}
