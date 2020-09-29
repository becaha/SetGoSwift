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
    
//    init(card: Card, cardRatio: CGFloat) {
//        self.card = card
//        self.cardRatio
//    }
    
//    @State private var isSelected = false
//    @State private var isMatched: Bool? = nil
//    @State private var cheat: Bool? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke(getColor(), lineWidth: 3)
                CardContent(geometry: geometry, card: card)
            }
//            .onAppear() {
//                setCard()
//            }
        }
        .aspectRatio(cardRatio, contentMode: .fit)
    }
    
    func getColor() -> Color {
        if card.cheat == true {
//        if cheat == true {
            return Color.orange
        }
        if card.isSelected {
//        if isSelected {
            if card.isMatched == true {
//            if isMatched == true {
                return Color.green
            }
            else if card.isMatched == false {
//            else if isMatched == false {
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
    
//    func setCard() {
//        isSelected = card.isSelected
//        isMatched = card.isMatched
//        cheat = card.cheat
//    }
    
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
