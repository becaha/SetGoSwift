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
    var selectedNum: Int
    var isMatch: Bool?
    
    let defaultDealNum = 12
    let maxSelectNum = 3
    
    init() {
        cards = SetGame.createSetCards()
        cardsInPlay = Array<Card>()
        selectedNum = 0
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
        return cards.shuffled() //as! NSMutableArray
    }
    
    mutating func removeSelected() {
        let currentSelected = findSelected()
        for i in 0..<currentSelected.count {
            cardsInPlay.remove(at: currentSelected[i])
        }
    }
    
    // user loses points for how many sets existed when he asked for more cards
    mutating func dealCardsPenalty() {
        let sets = getSets()
        score -= sets.count
    }
    
    mutating func deal(cardNum: Int) {
        if let isMatch = isMatch, isMatch == true {
            if (cardNum != 3 || selectedNum != 3) {
                print("error")
            }
            // remove/replace selected cards
            let currentSelected = findSelected()
            let selectedIndexA = currentSelected[0]
            let selectedIndexB = currentSelected[1]
            let selectedIndexC = currentSelected[2]
            
            if cards.count == 0 {
                removeSelected()
            }
            else {
                cardsInPlay[selectedIndexA] = cards[0]
                cardsInPlay[selectedIndexB] = cards[1]
                cardsInPlay[selectedIndexC] = cards[2]
            }
            
            resetSelected()
        }
        else if cards.count == 0 {
            return
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
    
    
    mutating func selectCard(at index: Int) {
        var selectIndex = index
        stopCheating()
        // if selected selectNum (3)
        if selectedNum == maxSelectNum {
            // if was a match, deal more cards
            if let isMatch = isMatch, isMatch == true {
                let selected = findSelected()
                deal(cardNum: maxSelectNum)
                // if selected card is a card in the match, do not select
                if selected.contains(index) {
                    return
                }
                // fix the index of the selected card only if no more cards in deck
                else if cards.count == 0 {
                    for selectedIndex in selected {
                        if selectIndex > selectedIndex {
                            selectIndex -= 1
                        }
                    }
                }
            }
            // reset selected cards
            resetSelected()
        }
        if cardsInPlay[selectIndex].isSelected {
            selectedNum -= 1
        }
        else {
            selectedNum += 1
        }
        cardsInPlay[selectIndex].isSelected.toggle()
        if selectedNum == maxSelectNum {
            checkMatch()
        }
    }
    
    mutating func resetSelected() {
        isMatch = nil
        for index in findSelected() {
            cardsInPlay[index].isSelected = false
            cardsInPlay[index].isMatched = nil
        }
        selectedNum = 0
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
    
    func findSelected() -> Array<Int> {
        var selectedIndices = Array<Int>()
        for (index, card) in cardsInPlay.enumerated() {
            if card.isSelected {
                selectedIndices.append(index)
            }
        }
        return selectedIndices.sorted { (A, B) -> Bool in
            A > B
        }
    }
    
    mutating func checkMatch() {
        if checkMatch(withIndices: findSelected()) {
            score += 1
            isMatch = true
        }
        else {
            score -= 1
            isMatch = false
        }
        setIsMatched()
    }
    
    mutating func setIsMatched() {
        for selectedIndex in findSelected() {
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
            for indexB in indexA + 1..<cardsInPlay.count {
                for indexC in indexB + 1..<cardsInPlay.count {
                    if checkMatch(withIndices: [indexA, indexB, indexC]) {
                        sets.append([indexA, indexB, indexC])
                    }
                }
            }
        }
        return sets
    }
    
    mutating func cheat() {
        score -= 1
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
