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
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(card.cheat ?? false == true ? Color.orange : Color.white)
                    .opacity(card.cheat ?? false == true ? 0.3 : 1)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke(getColor(), lineWidth: 3)
                CardContent(geometry: geometry, card: card)
            }
        }
        .aspectRatio(cardRatio, contentMode: .fit)
    }
    
    func getColor() -> Color {
        if card.isSelected {
            if card.isMatched == true {
                return Color.green
            }
            else if card.isMatched == false {
                return Color.red
            }
            else {
                return Color.yellow
            }
        }
        else {
            return Color.blue
        }
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
