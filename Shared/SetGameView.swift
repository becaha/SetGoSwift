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
                .padding()
            
            GeometryReader { geometry in
                LazyVGrid(columns: columns(for: geometry.size)) {
                    ForEach(setGame.cardsInPlay) { card in
                        CardView(card: card)
                            .onTapGesture
                            {
//                                setGame.choose(card)
                            }
                    }
                }
                .padding()
                .foregroundColor(.blue)
            }
            
            HStack {
                Button(action: {
                    
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
                    setGame.addNextCardsOf(amount: 3)
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
            
            Spacer()
        }
        
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    
    // MARK: - Drawing constants

    private let cardCornerRadius: CGFloat = 10.0
    private let desiredCardWidth: CGFloat = 120
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
    }
}
