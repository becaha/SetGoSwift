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
    
    var body: some View {
        VStack {
            Text("\(title)")
                .font(.title)
                .padding(.top)
            
            GeometryReader { geometry in
                LazyVGrid(columns: columns(for: geometry.size)) {
                    ForEach(setGame.cardsInPlay) { card in
                        CardView(card: card)
                            .onTapGesture
                            {
                                setGame.select(card: card)
                            }
                    }
                }
                .padding()
                .foregroundColor(.blue)
            }
            
            HStack {
                Button(action: {
                    setGame.newGame()
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
                    setGame.deal(cardNum: 3)
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
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        var desiredCardWidth: CGFloat = maxCardWidth
        if setGame.cardsInPlay.count > minCardsCount {
            var numCards = setGame.cardsInPlay.count
            var diff = CGFloat((setGame.cardsInPlay.count - minCardsCount) * (Int(minCardWidth) / (maxCardsCount - minCardsCount)))
            desiredCardWidth -= CGFloat((setGame.cardsInPlay.count - minCardsCount) * (Int(minCardWidth) / (maxCardsCount - minCardsCount)))
        }
        return Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    
    // MARK: - Drawing constants

    private let cardCornerRadius: CGFloat = 10.0
    private let minCardWidth: CGFloat = 60
    private let maxCardWidth: CGFloat = 120
    private let maxCardsCount: Int = 81
    private let minCardsCount: Int = 12
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
    }
}
