//
//  Array+indexOf.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/19/20.
//

import Foundation

extension Array where Element: Identifiable {
    func indexOf(element: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}

extension Array where Element: Equatable {
    mutating func remove(element: Element) -> Bool {
        for index in 0..<self.count {
            if self[index] == element {
                self.remove(at: index)
                return true
            }
        }
        return false
    }
}
