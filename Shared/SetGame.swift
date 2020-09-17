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
        cards = Array<Card>()
        score = 0
    }
    
    struct Card {
        var color: Int
        var shape: Int
        var pattern: Int
        var number: Int
    }
}
