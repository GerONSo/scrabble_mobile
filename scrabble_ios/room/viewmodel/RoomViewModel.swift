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
    private var roomId: String?
    
    @Published var roomName: String
    @Published var users: Array<UserItem>
    @Published var adminUserId: String
    
    init(roomId: String?) {
        roomName = "Untitled room"
        adminUserId = ""
        users = Array()
        self.roomId = roomId

        getRoom()
    }
    
    func getRoom() {
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.getRoom(roomId: self.roomId!, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.adminUserId = response.adminUserId
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
    
    func leaveRoom(switchTab: @escaping () -> Void) {
        let userId = UserDefaults.standard.string(forKey: "userid")!
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.leave(roomId: self.roomId!, userId: userId, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            switchTab()
                            UserDefaults.standard.set(nil, forKey: "currentRoomId")
                        } else {
                            self.logger.error("Cannot leave the room")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func kick(kickUserId: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.leave(roomId: self.roomId!, userId: kickUserId, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            self.getRoom()
                        } else {
                            self.logger.error("Cannot kick user")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func giveAdmin(userId: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.giveAdmin(roomId: self.roomId!, userId: userId, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            self.getRoom()
                        } else {
                            self.logger.error("Cannot kick user")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func deleteRoom(switchTab: @escaping () -> Void) {
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomInteractor.deleteRoom(roomId: self.roomId!, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            switchTab()
                            UserDefaults.standard.set(nil, forKey: "currentRoomId")
                        } else {
                            self.logger.error("Cannot delete the room")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
}
