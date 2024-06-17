//
//  GameViewModel.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation
import OSLog
import SwiftUI

enum GameState {
    case idle
    case running
    case paused
}

final class GameViewModel {
    private var player: PlayerModel = PlayerModel(isAdmin: true)
    private var remainingLetters: Int = 0
    private var board: [[BoardTile]] = Array(repeating: Array(repeating: BoardTile(letter: nil, multiplier: .empty), count: 15), count: 15)
    private var userLetters: [LetterTile] = [
        LetterTile(id: UUID(), letter: "F", value: 1),
        LetterTile(id: UUID(), letter: "L", value: 3),
        LetterTile(id: UUID(), letter: "Y", value: 3),
        LetterTile(id: UUID(), letter: "U", value: 3),
        LetterTile(id: UUID(), letter: "K", value: 3),
        LetterTile(id: UUID(), letter: "C", value: 3),
    ]
    private var unusedLetters: [LetterTile] = []
    
    private var gameInteractor = GameInteractor()
    
    private var gameState: GameState = .idle
    
    private var roomId: String?
    private var userId: String?
    
    var scores: [ScoreModel] = []
    
    private let logger = Logger()
    @AppStorage("log_status") var log_status: Bool = false
    
    /*public var gameState: String {
        
    };*/
    
    init() {}
    
    init(player: PlayerModel, remainingLetters: Int, board: [[BoardTile]], userLetters: [LetterTile], unusedLetters: [LetterTile]) {
        self.player = player
        self.remainingLetters = remainingLetters
        self.board = board
        self.userLetters = userLetters
        self.unusedLetters = unusedLetters
    }
    
    func startGame() {
        guard player.isAdmin else { return }
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.gameInteractor.startGame(roomId: self.roomId!, userId: self.userId!, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            self.gameState = .running
                        } else {
                            self.logger.error("Cannot start the game")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func pauseGame() {
        guard player.isAdmin else { return }
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.gameInteractor.pauseGame(roomId: self.roomId!, userId: self.userId!, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            self.gameState = .paused
                        } else {
                            self.logger.error("Cannot pause the game")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    func unpauseGame() {
        guard player.isAdmin else { return }
        guard roomId != nil else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.gameInteractor.unpauseGame(roomId: self.roomId!, userId: self.userId!, resultCompletion: { result in
                switch (result) {
                case .success(let response):
                    DispatchQueue.main.async {
                        if (response.success == true) {
                            self.gameState = .running
                        } else {
                            self.logger.error("Cannot unpause the game")
                        }
                    }
                case .failure(let error):
                    self.logger.error("\(error)")
                }
            })
        }
    }
    
    
    func scoreBoard() {
        let roomId = UserDefaults.standard.string(forKey: "currentRoomId")!
        gameInteractor.getScoreBoard(roomId: roomId, resultCompletion: { result in
            switch (result) {
            case .success(let response):
                DispatchQueue.main.async {
                    self.scores = response.scores.map({ score in
                        ScoreModel(name: score.name, score: score.score)
                    })
                }
            case .failure(let error):
                self.logger.error("\(error)")
            }
        })
    }
}
