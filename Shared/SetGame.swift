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
    
    let defaultDealNum = 12
    let selectNum = 3
    
    init() {
        cards = SetGame.createSetCards()
        cardsInPlay = Array<Card>()
        cardIndices = Array<Int>()
        score = 0
        deal(cardNum: defaultDealNum)
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
    
    // TODO: where to deal cards
    mutating func deal(cardNum: Int) {
        if cards.count == 0 {
            return
        }
        cardsInPlay.append(contentsOf: cards[0..<cardNum])
        // removes cardsInPlay from cards
        if cardNum >= cards.count {
            cards = Array<Card>()
            return
        }
        cards = Array(cards[cardNum...])
    }
    
    // TODO: do we want to use indices or isSelected
    mutating func selectCard(at index: Int) {
        if cardsInPlay[index].isSelected {
            let success = cardIndices.remove(element: index)
            if !success {
                return
            }
        }
        else {
            if cardIndices.count == selectNum {
                for index in cardsInPlay.indices {
                    cardsInPlay[index].isSelected = false
                }
                cardIndices = Array<Int>()
            }
            cardIndices.append(index)
        }
        cardsInPlay[index].isSelected.toggle()
        print("select \(cardsInPlay[index].isSelected)")
    }
}
