import Foundation

class UserInteractor {
    func auth(requestData: Encodable?, resultCompletion: @escaping (Result<RegistrationResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "register", requestData: requestData, authorizationToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4RDgwM0U1MS1CQTA3LTQ4OUYtOEQ4Ni04MUM1RjI5NTI1MDkifQ.PMVQBnBCwQNcH7IsevQpRruh64fC5ushST1WfPLFUxM", resultCompletion: resultCompletion)
    }
    
    func login(requestData: Encodable?, resultCompletion: @escaping (Result<LoginResponse>) -> Void) {
        BaseApi.makeRequest(httpMethod: "POST", endpoint: "login", requestData: requestData, authorizationToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4RDgwM0U1MS1CQTA3LTQ4OUYtOEQ4Ni04MUM1RjI5NTI1MDkifQ.PMVQBnBCwQNcH7IsevQpRruh64fC5ushST1WfPLFUxM", resultCompletion: resultCompletion)
    }
}
