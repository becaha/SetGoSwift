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
