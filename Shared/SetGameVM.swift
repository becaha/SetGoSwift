//
//  SetGameVM.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/17/20.
//

import Foundation

class SetGameVM: ObservableObject {
    @Published var game: SetGame = createGame()
    
    private static func createGame() -> SetGame {
        return SetGame()
    }
    
    // MARK: - Access to Model
    
    var cardsInPlay: Array<Card> {
        game.cardsInPlay
    }
    
    var cards: Array<Card> {
        game.cards
    }
    
    var score: String {
        game.score.toString()
    }
    
    var gameOver: Bool {
        game.gameOver
    }
    
    // MARK: - Intents
    
    func deal(numCards: Int) {
        game.deal(cardNum: numCards)
    }
    
    func dealCardsPenalty() {
        game.dealCardsPenalty()
    }
    
    func checkMatch() {
        game.checkMatch()
    }
    
    func select(card: Card) {
        let index = cardsInPlay.indexOf(element: card)!
        game.selectCard(at: index)
    }
    
    func cheat() {
        game.cheat()
    }
    
    func newGame() {
        game = SetGameVM.createGame()
    }
}
