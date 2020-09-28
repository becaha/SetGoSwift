//
//  CardView.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let cardRatio: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                if card.isSelected {
                    if card.isMatched == true {
                        RoundedRectangle(cornerRadius: cardCornerRadius).stroke(Color.green, lineWidth: 3)
                    }
                    else if card.isMatched == false {
                        RoundedRectangle(cornerRadius: cardCornerRadius).stroke(Color.red, lineWidth: 3)
                    }
                    else {
                        RoundedRectangle(cornerRadius: cardCornerRadius).stroke(Color.yellow, lineWidth: 3)
                    }
                }
                else {
                    RoundedRectangle(cornerRadius: cardCornerRadius).stroke(Color.blue, lineWidth: 3)
                }
                if card.cheat == true {
                    RoundedRectangle(cornerRadius: cardCornerRadius).stroke(Color.orange, lineWidth: 3)
                }
                CardContent(geometry: geometry, card: card)
            }
        }
        .aspectRatio(cardRatio, contentMode: .fit)
    }
    
    // MARK: - Drawing constants
    
    private let cardCornerRadius: CGFloat = 10.0
    private let fontScaleFactor: CGFloat = 0.50
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(color: 1, shape: 0, pattern: 0, number: 1), cardRatio: 3/2)
        
//        .frame(width: 100, height: 100, alignment: .center)
//        .padding()
    }
}
