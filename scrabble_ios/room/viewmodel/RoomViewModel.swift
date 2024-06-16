//
//  RoomViewModel.swift
//  scrabble_ios
//
//  Created by smgoncharov on 15.06.2024.
//

import Foundation
import OSLog

final class RoomViewModel: ObservableObject {
    private let roomInteractor = RoomInteractor()
    private let logger = Logger()
    
    @Published var roomName: String
    @Published var users: Array<UserItem>
    
    init(roomId: String) {
        roomName = "Untitled room"
        users = Array()
        
        getRoom(roomId: roomId)
    }
    
    func getRoom(roomId: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.getRoom(roomId: roomId, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.roomName = response.roomName
                        self.users = response.users.map { user in
                            UserItem(
                                id: user.id,
                                name: user.name,
                                description: (user.id == response.adminUserId) ? "admin" : "actions ›"
                            )
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
}
