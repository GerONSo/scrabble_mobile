import Foundation
import OSLog
import SwiftUI

final class ProfileViewModel: ObservableObject {
    private let profileInteractor = ProfileInteractor()
    private let logger = Logger()
    @Published var userLogin: String = ""
    @Published var userPassword: String = ""
    @AppStorage("log_status") var log_status: Bool = false
    
    func deleteUser() {
        DispatchQueue.global().async {
            self.profileInteractor.deleteUser(requestData: User(login: self.userLogin, password: self.userPassword), resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.log_status = false
                        UserDefaults.standard.set("", forKey: "jwtUser")
                        UserDefaults.standard.set("", forKey: "userid")
                        UserDefaults.standard.set("", forKey: "userLogin")
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
