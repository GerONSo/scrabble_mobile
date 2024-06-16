//
//  GameViewModel.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 17.06.2024.
//

import Foundation
import OSLog
import SwiftUI
import NaturalLanguage

enum GamePauseState {
    case idle
    case running
    case paused
}

final class GameViewModel {
    var player: PlayerModel = PlayerModel(isAdmin: true)
    @Published var remainingLetters: Int = 0
    private var savedBoard: [[BoardTile]] = Array(repeating: Array(repeating: BoardTile(letter: nil, multiplier: .empty), count: 15), count: 15)
    @Published var viewBoard: [[BoardTile]] = Array(repeating: Array(repeating: BoardTile(letter: nil, multiplier: .empty), count: 15), count: 15)
    private var userLetters: [LetterTile] = []
    @Published var unusedLetters: [LetterTile] = [
        LetterTile(id: UUID(), letter: "F", value: 1),
        LetterTile(id: UUID(), letter: "L", value: 3),
        LetterTile(id: UUID(), letter: "Y", value: 3),
        LetterTile(id: UUID(), letter: "U", value: 3),
        LetterTile(id: UUID(), letter: "K", value: 3),
        LetterTile(id: UUID(), letter: "C", value: 3),
    ]
    
    private var gameInteractor = GameInteractor()
    
    var gamePauseState: GamePauseState = .idle
    
    private var roomId: String?
    private var userId: String?
    
    private let logger = Logger()
    @AppStorage("log_status") var log_status: Bool = false
    
    public var pauseText: String {
        switch gamePauseState {
        case .idle:
            return (player.isAdmin) ? "Start" : "Wait"
        case .running:
            return (player.isAdmin) ? "Pause" : ""
        case .paused:
            return (player.isAdmin) ? "Unpause" : "Paused"
        }
    }
    
    public var pauseIcon: Image? {
        var name: String = ""
        switch gamePauseState {
        case .idle:
            name = (player.isAdmin) ? "play.fill" : "Wait"
        case .running:
            name = (player.isAdmin) ? "pause.fill" : ""
        case .paused:
            name = (player.isAdmin) ? "play.fill" : "pause.fill"
        }
        guard name != "" else { return nil }
        return Image(systemName: name)
    }
    
    init() {}
    
    init(player: PlayerModel, remainingLetters: Int, board: [[BoardTile]], userLetters: [LetterTile], unusedLetters: [LetterTile]) {
        self.player = player
        self.remainingLetters = remainingLetters
        self.userLetters = userLetters
        self.unusedLetters = unusedLetters
        //initializeSpecialTiles()
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
                            self.gamePauseState = .running
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
                            self.gamePauseState = .paused
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
                            self.gamePauseState = .running
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
     
    private func validateBoard(oldBoard: [[BoardTile]], newBoard: [[BoardTile]]) -> (Bool, [(String, Int, Int, String, String)]) {
        var placedLetters: [(Int, Int, String)] = []
        var words: [(String, Int, Int, String)] = []
     
        // Identify newly placed letters
        for row in 0..<15 {
            for column in 0..<15 {
                if oldBoard[row][column].letter == nil, let letter = newBoard[row][column].letter {
                    placedLetters.append((row, column, letter))
                }
            }
        }
     
        // Ensure there are placed letters
        guard !placedLetters.isEmpty else {
            return (false, [])
        }
     
        // Check each placed letter
        for (row, column, letter) in placedLetters {
            // Check horizontal words
            if column == 0 || newBoard[row][column-1].letter == nil {
                var word = letter
                var endColumn = column
                while endColumn + 1 < 15, let nextLetter = newBoard[row][endColumn + 1].letter {
                    word.append(nextLetter)
                    endColumn += 1
                }
                if word.count > 1 {
                    words.append((word, row, column, "r"))
                }
            }
     
            // Check vertical words
            if row == 0 || newBoard[row-1][column].letter == nil {
                var word = letter
                var endRow = row
                while endRow + 1 < 15, let nextLetter = newBoard[endRow + 1][column].letter {
                    word.append(nextLetter)
                    endRow += 1
                }
                if word.count > 1 {
                    words.append((word, row, column, "d"))
                }
            }
        }
     
        // Validate words
        for (word, _, _, _) in words {
            if !isValidWord(word: word) {
                return (false, [])
            }
        }
     
        // Collect used letters
        let usedLetters = placedLetters.map { $0.2 }.joined()
     
        return (true, words.map { ($0.0, $0.1, $0.2, $0.3, usedLetters) })
    }
     
    private func isValidWord(word: String) -> Bool {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = word
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
        let tags = tagger.tags(in: word.startIndex..<word.endIndex, unit: .word, scheme: .lemma, options: options)
        
        // If the tagger recognizes the word and returns a lemma, it's likely a valid word
        return tags.contains(where: { $0.0 != nil })
    }
}
