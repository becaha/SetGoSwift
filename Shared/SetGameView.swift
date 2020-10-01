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
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .opacity(backgroundOpacity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("\(title)")
                    .font(.system(size: 40))
                    .padding(.top, 10)
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                    
                    Rectangle()
                        .fill(playgroundColor)
                        .opacity(playgroundOpacity)
                    
                    ZStack {
                        VStack {
                            Text("Game Over")
                                .font(.system(size: 60))
                            
                            Text("Final Score: \(setGame.score)")
                                .font(.system(size: 40))
                            
                            GameButton(text: "Play Again", action: newGame)
                                .frame(height: 60)
                                .padding()

                        }
                        .opacity(setGame.gameOver ? 1 : 0)
                    
                        GeometryReader { geometry in
                            LazyVGrid(columns: columns(for: geometry.size)) {
                                ForEach(setGame.cardsInPlay) { card in
                                    CardView(card: card, cardRatio: cardRatio)
                                        .onTapGesture
                                        {
                                            withAnimation {
                                                setGame.select(card: card)
                                            }
                                        }
                                        .transition(AnyTransition.offset(randomLocationOffScreen(for: geometry.size)))
                                }
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .onAppear {
                                dealWithAnimation(numCards: defaultDealNum)
                            }
                            .opacity(setGame.gameOver ? 0.05 : 1)
                        }
                    }
                }
                
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(sectionColor)
                            .opacity(sectionOpacity)
                        
                        Text("Score: \(setGame.score)")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }
                .frame(height: 60)
                .opacity(setGame.gameOver ? 0.05 : 1)
                
                ZStack {
                    Rectangle()
                        .fill(sectionColor)
                        .opacity(sectionOpacity)
                    
                    HStack {
                        GameButton(text: "New Game", action: newGame)
                        
                        GameButton(text: "Deal 3", action: deal3Cards)
                            .disabled(setGame.cards.count == 0)
                            .opacity(setGame.cards.count == 0 ? 0.5 : 1)
                        
                        GameButton(text: "Cheat", action: setGame.cheat)
                    }
                    .padding()
                }
                .padding(.vertical, 0)
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 90)
                .opacity(setGame.gameOver ? 0.05 : 1)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func newGame() {
        withAnimation {
            setGame.newGame()
        }
        dealWithAnimation(numCards: defaultDealNum)
    }
    
    private func deal3Cards() {
        setGame.dealCardsPenalty()
        dealWithAnimation(numCards: 3)
    }
    
    @ViewBuilder
    func GameButton(text: String, action: @escaping () -> Void) -> some View {
        Button(action:
            action
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .stroke(buttonStrokeColor, lineWidth: buttonStrokeWeight)

                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .fill(buttonColor)
                    .opacity(buttonOpacity)

                Text("\(text)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(buttonTextColor)
            }
        }
    }
    
    private func dealWithAnimation(numCards: Int) {
        for i in 0..<numCards {
            let delay = Double(i) / 7
            
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
        if setGame.cardsInPlay.count > 72 {
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
    
    private let buttonColor = Color.blue
    private let buttonOpacity = 0.8
    private let buttonStrokeColor = Color.blue
    private let buttonStrokeWeight: CGFloat = 2.0
    private let buttonTextColor = Color.black
    
    private let backgroundColor = Color.blue
    private let backgroundOpacity = 0.2
    private let sectionColor = Color.blue
    private let sectionOpacity = 0.2
    private let playgroundColor = Color.blue
    private let playgroundOpacity = 0.1
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
    }
}
