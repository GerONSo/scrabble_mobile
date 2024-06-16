import Foundation
struct User: Encodable {
    var login: String
    var password: String
}

struct RegistrationResponse: Decodable {
    var id: String
    var userid: String
    var password: String
    var login: String
}

struct LoginResponse: Decodable {
    var userid: String
    var jwt: String
    var login: String
}
