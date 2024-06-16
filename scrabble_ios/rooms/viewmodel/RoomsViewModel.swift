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
}
