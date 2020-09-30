//
//  SetGameVM.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/17/20.
//

import Foundation

class SetGameVM: ObservableObject {
    @Published var game: SetGame = createGame()
    var deckIndexStart = 0
    var numCards = 12
    
    private static func createGame() -> SetGame {
        return SetGame()
    }
    
    // MARK: - Access to Model
    
    var cardsInPlay: Array<Card> {
        game.cardsInPlay
//        (game.cardsInPlay as NSArray) as! Array<Card>
    }
    
    var cards: Array<Card> {
        var gameCards = game.cards
        return gameCards
//        (game.cards as NSArray) as! Array<Card>
    }
    
    var score: String {
        game.score.toString()
    }
    
    // MARK: - Intents
    
    func deal(numCards: Int) -> Void {
        game.deal(cardNum: numCards)
    }
    
    func checkMatch() {
        game.checkMatch()
    }
    
    func select(card: Card) {
        let index = cardsInPlay.indexOf(element: card)!
        game.selectCard(at: index)
//        game.select(card)
    }
    
    func cheat() {
        game.cheat()
    }
    
    func newGame() {
        game = SetGameVM.createGame()
        let cardsHelp = game.cards
    }
}
