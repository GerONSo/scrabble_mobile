import SwiftUI
import UniformTypeIdentifiers

struct GameView: View {
    @State private var remainingLetters: Int = 100 // Example initial count
    @State private var board: [[BoardTile]] = Array(repeating: Array(repeating: BoardTile(letter: nil, multiplier: .empty), count: 15), count: 15)
    @State private var userLetters: [LetterTile] = [
        LetterTile(id: UUID(), letter: "F", value: 1),
        LetterTile(id: UUID(), letter: "L", value: 3),
        LetterTile(id: UUID(), letter: "Y", value: 3),
        LetterTile(id: UUID(), letter: "U", value: 3),
        LetterTile(id: UUID(), letter: "K", value: 3),
        LetterTile(id: UUID(), letter: "C", value: 3),
    ]
    @State private var unusedLetters: [LetterTile] = []
    @State var shouldShowScore: Bool = false
    
    @ObservedObject private var gameModel: GameViewModel
    
    init() {
        gameModel = GameViewModel()
    }
    
    init(gameModel_: GameViewModel) {
        gameModel = gameModel_
    }
    
    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Spacer()
                Button(action: {
                    // Scoreboard action
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start")
                    }
                }
                Button(action: {
                    // Scoreboard action
                    shouldShowScore.toggle()
                    gameModel.scoreBoard()
                }) {
                    HStack {
                        Image(systemName: "list.number")
                        Text("Scoreboard")
                    }
                }
                Text("Remaining: \(remainingLetters)")
                    .padding(.leading, 10)
                Spacer()
            }
            .padding()
            .background(Color(UIColor.lightGray))
            .foregroundColor(.white)
            
            Spacer()
            
            // Scrabble Board
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(0..<15, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<15, id: \.self) { column in
                                    TileView(tile: board[row][column])
                                        //.frame(width: geometry.size.width / 16, height: geometry.size.width / 16)
                                        .frame(width: 37, height: 37)
                                        .border(Color.gray, width: 1)
                                        .onDrop(of: [UTType.plainText], isTargeted: nil) { providers in
                                            handleDrop(providers: providers, row: row, column: column)
                                        }
                                }
                            }
                        }
                    }
                    
                    //.frame(width: geometry.size.width, height: geometry.size.width)
                    .background(Color.white) // Ensure background extends properly
                }
                //.scaledToFill()
                //.frame(height: geometry.size.width) // Limit height to width to keep it square
            }
            //.resizable()
            //.scaledToFill()
            
            Spacer()
            
            // User's Letter Rack
            HStack {
                ForEach(userLetters) { letter in
                    LetterTileView(letterTile: letter)
                        .onDrag {
                            let encoder = JSONEncoder()
                            if let data = try? encoder.encode(letter) {
                                return NSItemProvider(object: NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
                            }
                            return NSItemProvider()
                        }
                }
                Button(action: {
                    // SendWordsAction
                    
                    // gets scoreboard
                    gameModel.scoreBoard()
                }) {
                    ZStack {
                        Color.green
                        Image(systemName: "hand.thumbsup.fill")
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
            .background(Color(UIColor.lightGray))
        }
        .onAppear {
            initializeSpecialTiles()
        }
        .sheet(isPresented: $shouldShowScore) {
            Text("Scoreboard")
                .bold()
                .font(.title2)
                .padding()
            VStack {
                ForEach($gameModel.scores) { $userScore in
                    HStack {
                        Text(userScore.name)
                            .font(.title3)
                        Spacer()
                        Text(userScore.score)
                            .font(.title3)
                            .bold()
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
    
    private func initializeSpecialTiles() {
        // Initialize special tiles (TW, DW, DL, TL) on the board
        let specialTiles: [(Int, Int, BoardTile.MultiplierType)] = [
            (0, 0, .TW), (0, 7, .TW), (0, 14, .TW), (7, 0, .TW), (7, 14, .TW), (14, 0, .TW), (14, 7, .TW), (14, 14, .TW),
            (1, 1, .DW), (2, 2, .DW), (3, 3, .DW), (4, 4, .DW), (10, 10, .DW), (11, 11, .DW), (12, 12, .DW), (13, 13, .DW),
            (1, 13, .DW), (2, 12, .DW), (3, 11, .DW), (4, 10, .DW), (10, 4, .DW), (11, 3, .DW), (12, 2, .DW), (13, 1, .DW),
            (5, 1, .TL), (9, 1, .TL), (1, 5, .TL), (1, 9, .TL), (5, 5, .TL), (9, 5, .TL), (5, 9, .TL), (9, 9, .TL),
            (13, 5, .TL), (13, 9, .TL), (5, 13, .TL), (9, 13, .TL), (3, 0, .DL), (11, 0, .DL), (6, 2, .DL), (8, 2, .DL),
            (0, 3, .DL), (0, 11, .DL), (2, 6, .DL), (2, 8, .DL), (6, 6, .DL), (6, 8, .DL), (8, 6, .DL), (8, 8, .DL),
            (3, 14, .DL), (11, 14, .DL), (14, 3, .DL), (14, 11, .DL), (2, 12, .DL), (12, 2, .DL), (3, 11, .DL), (11, 3, .DL)
        ]
        
        for (row, column, multiplier) in specialTiles {
            board[row][column].multiplier = multiplier
        }
    }
    
    private func handleDrop(providers: [NSItemProvider], row: Int, column: Int) -> Bool {
        if let provider = providers.first {
            provider.loadItem(forTypeIdentifier: UTType.plainText.identifier as String, options: nil) { (item, error) in
                if let data = item as? Data, let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    let decoder = JSONDecoder()
                    if let letterTile = try? decoder.decode(LetterTile.self, from: string.data(using: String.Encoding.utf8.rawValue)!) {
                        DispatchQueue.main.async {
                            if board[row][column].letter == nil { // Check if the cell is empty
                                board[row][column].letter = letterTile.letter
                                // Update remaining letters and remove from userLetters
                                if let index = userLetters.firstIndex(where: { $0.id == letterTile.id }) {
                                    userLetters.remove(at: index) // Remove the letter from userLetters
                                    remainingLetters -= 1 // Decrement remaining letters
                                }
                            }
                        }
                    }
                }
            }
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameModel_: GameViewModel())
    }
}
