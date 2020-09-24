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
    var selectedIndices: Array<Int>
    var isMatch: Bool?
    
    let defaultDealNum = 12
    let selectNum = 3
    
    init() {
        cards = SetGame.createSetCards()
        cardsInPlay = Array<Card>()
        selectedIndices = Array<Int>()
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
        if let isMatch = isMatch, isMatch == true {
            if (cardNum != 3 || selectedIndices.count != 3) {
                print("error")
            }
            for (index, selectedIndex) in selectedIndices.enumerated() {
                cardsInPlay[selectedIndex] = cards[index]
            }
        }
        else {
            cardsInPlay.append(contentsOf: cards[0..<cardNum])
        }
        // removes cardsInPlay from cards
        if cardNum >= cards.count {
            cards = Array<Card>()
            return
        }
        cards = Array(cards[cardNum...])
    }
    
    // TODO: do we want to use indices or isSelected
    mutating func selectCard(at index: Int) {
        stopCheating()
        // reset selection
        if selectedIndices.count == selectNum {
            resetSelected()
        }
        if cardsInPlay[index].isSelected {
            let success = selectedIndices.remove(element: index)
            if !success {
                return
            }
        }
        else {
            selectedIndices.append(index)
        }
        cardsInPlay[index].isSelected.toggle()
        if selectedIndices.count == selectNum {
            checkMatch()
        }
        print("select \(cardsInPlay[index].isSelected)")
    }
    
    mutating func resetSelected() {
        if let isMatch = isMatch, isMatch == true {
            deal(cardNum: selectNum)
        }
        isMatch = nil
        for index in selectedIndices {
            cardsInPlay[index].isSelected = false
            cardsInPlay[index].isMatched = nil
        }
        selectedIndices = Array<Int>()
    }
    
    func checkMatch(withIndices indices: Array<Int>) -> Bool {
        let cardA = cardsInPlay[indices[0]]
        let cardB = cardsInPlay[indices[1]]
        let cardC = cardsInPlay[indices[2]]

        if hasMatchingAttribute(attA: cardA.color.rawValue, attB: cardB.color.rawValue, attC: cardC.color.rawValue)
        && hasMatchingAttribute(attA: cardA.pattern.rawValue, attB: cardB.pattern.rawValue, attC: cardC.pattern.rawValue)
        && hasMatchingAttribute(attA: cardA.shape.rawValue, attB: cardB.shape.rawValue, attC: cardC.shape.rawValue)
            && hasMatchingAttribute(attA: cardA.number, attB: cardB.number, attC: cardC.number) {
            return true
        }
        return false
    }
    
    mutating func checkMatch() {
        if checkMatch(withIndices: selectedIndices) {
            isMatch = true
        }
        else {
            isMatch = false
        }
        setIsMatched()
    }
    
    mutating func setIsMatched() {
        for selectedIndex in selectedIndices {
            cardsInPlay[selectedIndex].isMatched = isMatch
        }
    }
    
    func hasMatchingAttribute(attA: Int, attB: Int, attC: Int) -> Bool {
        if (attA == attB && attB == attC) || (attA != attB && attA != attC && attB != attC) {
            return true
        }
        return false
    }
    
    func getSets() -> Array<Array<Int>> {
        var sets = Array<Array<Int>>()
        
        for indexA in 0..<cardsInPlay.count {
            for indexB in 1..<cardsInPlay.count {
                for indexC in 2..<cardsInPlay.count {
                    if checkMatch(withIndices: [indexA, indexB, indexC]) {
                        sets.append([indexA, indexB, indexC])
                    }
                }
            }
        }
        return sets
    }
    
    mutating func cheat() {
        let sets = getSets()
        if sets.count > 0 {
            for index in sets[0] {
                cardsInPlay[index].cheat = true
            }
        }
    }
    
    mutating func stopCheating() {
        for (index, _) in cardsInPlay.enumerated() {
            cardsInPlay[index].cheat = false
        }
    }
}
