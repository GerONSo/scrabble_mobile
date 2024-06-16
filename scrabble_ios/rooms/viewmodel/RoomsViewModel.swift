//
//  RoomsViewModel.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation
import OSLog

final class RoomsViewModel: ObservableObject {
    private let roomsInteractor = RoomsInteractor()
    private let logger = Logger()
    
    @Published var rooms: Array<RoomItem> = Array()
    @Published var inviteCodeText: String = ""
    @Published var createRoomNameText: String = ""
    @Published var isOn: Bool = false
    
    init() {
        getRooms()
    }
    
    func getRooms() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.roomsInteractor.getRooms(resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.rooms = response.rooms.map({ item in
                            RoomItem(id: item.id, name: item.name)
                        })
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func join(roomId: String?, inviteCode: String?, switchTab: @escaping () -> Void) {
        let userId = UserDefaults.standard.string(forKey: "userid")!
        roomsInteractor.join(userId: userId, roomId: roomId, inviteCode: inviteCode, resultCompletion: { result in
            switch (result) {
            case .success(let response):
                DispatchQueue.main.async {
                    if (response.success == true) {
                        switchTab()
                        UserDefaults.standard.set(roomId, forKey: "currentRoomId")
                    } else {
                        self.logger.error("Cannot join room")
                    }
                }
            case .failure(let error):
                self.logger.error("\(error)")
            }
        })
    }
    
    func create(switchTab: @escaping () -> Void) {
        let userId = UserDefaults.standard.string(forKey: "userid")!
        roomsInteractor.create(userId: userId, roomName: createRoomNameText, isPrivate: isOn, resultCompletion: { result in
            switch (result) {
            case .success(let response):
                DispatchQueue.main.async {
                    switchTab()
                    UserDefaults.standard.set(response.roomId, forKey: "currentRoomId")
                }
            case .failure(let error):
                self.logger.error("\(error)")
            }
        })
    }
}
