//
//  SetGameView.swift
//  Shared
//
//  Created by Rebecca Nybo on 9/17/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameVM
    
    let title = "Set Go"
    
    func randomLocationOffScreen(for size: CGSize) -> CGSize {
        var randomSize = CGSize.zero
        let randomAngle = Double.random(in: 0..<Double.pi * 2)
        let scaleFactor = max(size.width, size.height) * 1.5
        
        randomSize.width = CGFloat(sin(randomAngle)) * scaleFactor
        randomSize.height = CGFloat(cos(randomAngle)) * scaleFactor
        
        return randomSize
    }
    
    var body: some View {
        VStack {
            Text("\(title)")
                .font(.title)
                .padding(.top)
            
            GeometryReader { geometry in
                LazyVGrid(columns: columns(for: geometry.size)) {
                    ForEach(setGame.cardsInPlay) { card in
                        CardView(card: card, cardRatio: cardRatio)
//                            .animation(card.inPlay ?
//                                        Animation.easeInOut.delay(1) : .default)
                            .onTapGesture
                            {
                                setGame.select(card: card)
                            }
                    }
                    .transition(AnyTransition.offset(randomLocationOffScreen(for: geometry.size)))
                }
                .padding()
                .foregroundColor(.blue)
                .onAppear {
                    dealWithAnimation(numCards: defaultDealNum)
                }
            }
            
            HStack {
                Button(action: {
                    setGame.newGame()
                    dealWithAnimation(numCards: defaultDealNum)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cardCornerRadius)
                            .fill(Color.green)
                            .padding()
                        
                        Text("New Game")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.black)
                    }
                    .aspectRatio(4/2, contentMode: .fit)
                }
                    
                Button(action: {
                    dealWithAnimation(numCards: 3)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.green)
                            .padding()
                        
                        Text("Add 3 Cards")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.black)
                    }
                    .aspectRatio(4/2, contentMode: .fit)
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                setGame.cheat()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.green)
                        .padding()
                    
                    Text("Cheat")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.black)
                }
                .aspectRatio(5/1, contentMode: .fit)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
    private func dealWithAnimation(numCards: Int) {
        for i in 0..<numCards {
            let delay = Double(i) * 0.5
            
            withAnimation(Animation.easeInOut.delay(delay)) {
                setGame.deal(numCards: 1)
            }
        }
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
//        if setGame.cardsInPlay.count
//        var numCols = 3
//        var numRows = setGame.cardsInPlay.count / numCols
//
//        var cardWidth = size.width / CGFloat(numCols)
//        var cardHeight = cardWidth * CGFloat(1/cardRatio)
//
//        var totalHeight = CGFloat(numRows) * cardHeight
        var count = 3
        if setGame.cardsInPlay.count > 78 {
            count = 7
        }
        else if setGame.cardsInPlay.count > 50 {
            count = 6
        }
        else if setGame.cardsInPlay.count > 32 {
            count = 5
        }
        else if setGame.cardsInPlay.count > 18 {
            count = 4
        }
        
        return Array(repeating: GridItem(.flexible()), count: count)
    }
    
    // MARK: - Drawing constants
    
    private let defaultDealNum = 12

    private let cardRatio: CGFloat = 3/2
    private let cardCornerRadius: CGFloat = 10.0
    private let minCardWidth: CGFloat = 60
    private let minCardHeight: CGFloat = 40
    private let maxCardWidth: CGFloat = 120
    private let maxCardHeight: CGFloat = 80
    private let maxCardsCount: Int = 81
    private let minCardsCount: Int = 12
    private let minRows = 4
    private let maxRows = 14
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
    }
}
