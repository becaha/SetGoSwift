//
//  SetGame.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/17/20.
//

import Foundation

struct SetGame {
    var cards: Array<Card>
    var score: Int
    
    init() {
        cards = SetGame.createSetCards()
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
        return cards
    }
}
