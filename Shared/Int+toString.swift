//
//  Int+toString.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import Foundation

extension Int {
    func toString() -> String {
        let formatter  = NumberFormatter()
        return formatter.string(from: self as NSNumber)!
    }
}

