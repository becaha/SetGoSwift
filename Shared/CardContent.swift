//
//  CardContent.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardContent: View {
    let card: Card
    let geometry
    
    var body: some View {
        Text("\(card.shape.rawValue), \(card.color.rawValue), " +
                "\(card.pattern.rawValue), \(card.number)")
            .font(systemFont(for: geometry.size))
    }
}

struct CardContent_Previews: PreviewProvider {
    static var previews: some View {
        CardContent(card: Card(color: 0, shape: 0, pattern: 0, number: 0))
    }
}
