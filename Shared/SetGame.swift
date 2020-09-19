//
//  SetGame.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/17/20.
//

import Foundation

struct SetGame {
    var cards: Array<Card>
    var cardsInPlay: Array<Card>
    var score: Int
    var cardIndices: Array<Int>
    
    let numCards = 12
    let selectNum = 3
    
    init() {
        cards = SetGame.createSetCards()
        cardsInPlay = Array(cards[0..<numCards])
        cards = Array(cards[numCards...])
        cardIndices = Array<Int>()
        score = 0
    }
    
    private static func createSetCards() -> Array<Card> {
        var cards = Array<Card>()
        for color in 0..<3 {
            for shape in 0..<3 {
                for pattern in 0..<3 {
                    for number in 0..<3 {
                        cards.append(Card(color: color, shape: shape, pattern: pattern, number: number))
                    }
                }
            }
        }
        return cards.shuffled()
    }
    
    func deal(cardNum: Int) {
        
    }
    
    mutating func selectCard(at index: Int) {
        if cardIndices.count == selectNum {
            cardIndices = Array<Int>()
        }
        cardIndices.append(index)
        cardsInPlay[index].isSelected = true
    }
}
