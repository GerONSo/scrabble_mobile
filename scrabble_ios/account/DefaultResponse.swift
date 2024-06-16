import Foundation
import Vapor

final class DefaultResponse: Content {
    var success: Bool
    
    init(success: Bool) {
        self.success = success
    }
    
    enum CodingKeys: String, CodingKey {
        case success
    }
}
