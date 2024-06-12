//
//  RoomsViewModel.swift
//  scrabble_ios
//
//  Created by smgoncharov on 12.06.2024.
//

import Foundation
import OSLog

final class RoomsViewModel: ObservableObject {
    let roomsInteractor = RoomsInteractor()
    let logger = Logger()
    
    @Published var rooms: Array<RoomItem> = Array()
    
    init() {
        getRooms()
    }
    
    func getRooms() {
        roomsInteractor.getRooms(resultCompletion: { result in
            switch (result) {
            case .success(let response):
                self.rooms = response.rooms.map({ item in
                    RoomItem(id: item.id, name: item.name)
                })
                for i in self.rooms {
                    print(i.id + " " + i.name)
                }
            case .failure(let error):
                self.logger.error("\(error)")
            }
        })
    }
}
