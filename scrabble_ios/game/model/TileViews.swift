//
//  TileViews.swift
//  scrabble_ios
//
//  Created by Андрей Королев on 16.06.2024.
//

import SwiftUI

struct TileView: View {
    var tile: BoardTile
    
    var body: some View {
        ZStack {
            switch tile.multiplier {
            case .TW:
                Color.red
                if tile.letter == nil { Text("TW").foregroundColor(.white) }
            case .DW:
                Color.blue
                if tile.letter == nil { Text("DW").foregroundColor(.white) }
            case .DL:
                Color.green
                if tile.letter == nil { Text("DL").foregroundColor(.white) }
            case .TL:
                Color.yellow
                if tile.letter == nil { Text("TL").foregroundColor(.white) }
            case .empty:
                Color.white
            }
            
            if let letter = tile.letter {
                Text(letter)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }
}

struct LetterTileView: View {
    var letterTile: LetterTile
    
    var body: some View {
        ZStack {
            Color.white
            Text(letterTile.letter)
                .font(.largeTitle)
                .foregroundColor(.black)
        }
        .frame(width: 40, height: 40)
        .border(Color.black, width: 2)
    }
}
