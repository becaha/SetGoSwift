//
//  Card.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import Foundation

struct Card: Identifiable {
    var color: ColorProp
    var shape: ShapeProp
    var pattern: PatternProp
    var number: Int
    var isSelected: Bool
    var id: UUID
    var isMatched: Bool?
    var cheat: Bool?
    
    init(color: Int, shape: Int, pattern: Int, number: Int) {
        self.color = ColorProp(rawValue: color)!
        self.shape = ShapeProp(rawValue: shape)!
        self.pattern = PatternProp(rawValue: pattern)!
        self.number = number
        isSelected = false
        id = UUID()
    }
}
