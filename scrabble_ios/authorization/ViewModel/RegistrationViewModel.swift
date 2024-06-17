import Foundation
import OSLog
import SwiftUI

final class RegistrationViewModel: ObservableObject {
    private let userInteractor = UserInteractor()
    private let logger = Logger()
    @Published var userLogin: String = ""
    @Published var userPassword: String = ""
    @Published var registered: Bool = false
    
    func register() {
        DispatchQueue.global().async {
            self.userInteractor.auth(requestData: User(login: self.userLogin, password: self.userPassword), resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.registered = true
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
        registered = false
    }
}
