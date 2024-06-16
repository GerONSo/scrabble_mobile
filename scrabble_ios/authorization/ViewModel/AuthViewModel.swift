import Foundation
import OSLog
import SwiftUI

final class AuthViewModel: ObservableObject {
    private let userInteractor = UserInteractor()
    private let logger = Logger()
    @Published var userLogin: String = ""
    @Published var userPassword: String = ""
    @AppStorage("log_status") var log_status: Bool = false
    
    func login() {
        DispatchQueue.global().async {
            self.userInteractor.login(requestData: User(login: self.userLogin, password: self.userPassword), resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.log_status = true
                        UserDefaults.standard.set(response.jwt, forKey: "jwtUser")
                        UserDefaults.standard.set(response.userid, forKey: "userid")
                        UserDefaults.standard.set(response.login, forKey: "userLogin")
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func clearFields() {
        userLogin = ""
        userPassword = ""
    }
}
