//
//  SetGame.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/17/20.
//

import Foundation

struct SetGame {
//    var cards: NSMutableArray
//    var cardsInPlay: NSMutableArray
    var cards: Array<Card>
    var cardsInPlay: Array<Card>
    var score: Int
    var selectedNum: Int
    var isMatch: Bool?
    
    let defaultDealNum = 12
    let maxSelectNum = 3
    
    init() {
        cards = SetGame.createSetCards()
//        cardsInPlay = NSMutableArray()
        cardsInPlay = Array<Card>()
        selectedNum = 0
        score = 0
//        deal(cardNum: defaultDealNum)
    }
    
//    private static func createSetCards() -> NSMutableArray {
    private static func createSetCards() -> Array<Card> {
//        var cards = NSMutableArray()
        var cards = Array<Card>()
        for color in 0..<3 {
            for shape in 0..<3 {
                for pattern in 0..<3 {
                    for number in 0..<3 {
//                        cards.add(Card(color: color, shape: shape, pattern: pattern, number: number))
                        cards.append(Card(color: color, shape: shape, pattern: pattern, number: number))
                    }
                }
            }
        }
        return cards.shuffled() //as! NSMutableArray
    }
    
    // TODO: where to deal cards
    mutating func deal(cardNum: Int) {
        if let isMatch = isMatch, isMatch == true {
            if (cardNum != 3 || selectedNum != 3) {
                print("error")
            }
            for (index, selectedIndex) in findSelected().enumerated() {
                if cards.count == 0 {
//                    cardsInPlay.removeObject(at: selectedIndex)
                    cardsInPlay.remove(at: selectedIndex)
//                    cardsInPlay[selectedIndex].inPlay = false
                }
                else {
                    cardsInPlay[selectedIndex] = cards[index]
//                    cardsInPlay[selectedIndex].inPlay = false
//                    cardsInPlay.insert(cards[index], at: selectedIndex + 1)
//                    cardsInPlay[selectedIndex + 1].inPlay = true
                }
            }
            resetSelected()
        }
        else if cards.count == 0 {
            return
        }
        else {
//            cardsInPlay.addObjects(from: cards.subarray(with: NSRange(0..<cardNum)))
            cardsInPlay.append(contentsOf: cards[0..<cardNum])
        }
        // removes cardsInPlay from cards
        if cardNum >= cards.count {
//            cards = NSMutableArray()
            cards = Array<Card>()
            return
        }
        cards = Array(cards[cardNum...])
//        cards.setArray(cards.subarray(with: NSRange(cardNum...)))
    }
    
    
    // TODO: do we want to use indices or isSelected
//    mutating func select(_ card: Card) {
    mutating func selectCard(at index: Int) {
        stopCheating()
        // if selected selectNum (3)
        if selectedNum == maxSelectNum {
            // if was a match, deal more cards
            if let isMatch = isMatch, isMatch == true {
                deal(cardNum: maxSelectNum)
                // if selected card is a card in the match, do not select
                if findSelected().contains(index) {
                    return
                }
            }
            // reset selected cards
            resetSelected()
        }
//        if card.isSelected {
        if cardsInPlay[index].isSelected {
            selectedNum -= 1
        }
        else {
            selectedNum += 1
        }
        cardsInPlay[index].isSelected.toggle()
//        card.isSelected.toggle()
        if selectedNum == maxSelectNum {
            checkMatch()
        }
//        print("select \(card.isSelected)")
        print("select \(cardsInPlay[index].isSelected)")
    }
    
    mutating func resetSelected() {
        isMatch = nil
        for index in findSelected() {
//            (cardsInPlay[index] as! Card).isSelected = false
//            (cardsInPlay[index] as! Card).isMatched = nil
            cardsInPlay[index].isSelected = false
            cardsInPlay[index].isMatched = nil
        }
        selectedNum = 0
    }
    
    func checkMatch(withIndices indices: Array<Int>) -> Bool {
        let cardA = cardsInPlay[indices[0]] // as! Card
        let cardB = cardsInPlay[indices[1]] // as! Card
        let cardC = cardsInPlay[indices[2]] // as! Card

        if hasMatchingAttribute(attA: cardA.color.rawValue, attB: cardB.color.rawValue, attC: cardC.color.rawValue)
        && hasMatchingAttribute(attA: cardA.pattern.rawValue, attB: cardB.pattern.rawValue, attC: cardC.pattern.rawValue)
        && hasMatchingAttribute(attA: cardA.shape.rawValue, attB: cardB.shape.rawValue, attC: cardC.shape.rawValue)
            && hasMatchingAttribute(attA: cardA.number, attB: cardB.number, attC: cardC.number) {
            print("set \(cardA.number), \(cardB.number), \(cardC.number)")
            return true
        }
        return false
    }
    
    func findSelected() -> Array<Int> {
        var selectedIndices = Array<Int>()
        for (index, card) in cardsInPlay.enumerated() {
//            if (card as! Card).isSelected {
            if card.isSelected {
                selectedIndices.append(index)
            }
        }
        print("selected found \(selectedIndices)")
        return selectedIndices
    }
    
    mutating func checkMatch() {
        if checkMatch(withIndices: findSelected()) {
            isMatch = true
        }
        else {
            isMatch = false
        }
        setIsMatched()
    }
    
    mutating func setIsMatched() {
        for selectedIndex in findSelected() {
//            (cardsInPlay[selectedIndex] as! Card).isMatched = isMatch
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
                        print("cheat")
                        print("\(indexA), \(indexB), \(indexC)")
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
//                (cardsInPlay[index] as! Card).cheat = true
                cardsInPlay[index].cheat = true
            }
        }
    }
    
    mutating func stopCheating() {
        for (index, _) in cardsInPlay.enumerated() {
//            (cardsInPlay[index] as! Card).cheat = false
            cardsInPlay[index].cheat = false
        }
    }
}
