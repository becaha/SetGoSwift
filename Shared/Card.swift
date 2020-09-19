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
    var id: Int
    
    init(color: Int, shape: Int, pattern: Int, number: Int) {
        self.color = ColorProp(rawValue: color)!
        self.shape = ShapeProp(rawValue: shape)!
        self.pattern = PatternProp(rawValue: pattern)!
        self.number = number + 1
        id = (color * 27) + (shape * 9) + (pattern * 3) + number
    }
}
