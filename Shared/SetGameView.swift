//
//  SetGameView.swift
//  Shared
//
//  Created by Rebecca Nybo on 9/17/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameVM
    
    @State private var gameOver = false
    
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
        GeometryReader { screenGeometry in
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                    .opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("\(title)")
                        .font(.system(size: 40))
                        .padding(.vertical, screenGeometry.size.height * paddingFactorLarge)
                    
                    Spacer()
//                        .frame(height: screenGeometry.size.height * spacingFactor)
                    
                    GeometryReader { playgroundGeometry in

                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                            
                            Rectangle()
                                .fill(playgroundColor)
                                .opacity(playgroundOpacity)
                            
                            Rectangle()
                                .stroke(buttonStrokeColor)
                                .opacity(0.8)
                            
                            ZStack {
                                VStack {
                                    Text("Game Over")
                                        .font(.system(size: 60))
                                    
                                    Text("Final Score: \(setGame.score)")
                                        .font(.system(size: 40))
                                    
                                    GameButton(text: "Play Again", action: newGame, height: screenGeometry.size.height * sectionFactor)
                                }
                                .opacity(gameOver ? 1 : 0)
                                
                                LazyVGrid(columns: columns(for: playgroundGeometry.size)) {
                                    ForEach(setGame.cardsInPlay) { card in
                                        CardView(card: card, cardRatio: cardRatio)
                                            .onTapGesture
                                            {
                                                withAnimation {
                                                    setGame.select(card: card)
                                                    gameOver = setGame.gameOver
                                                }
                                            }
                                            .transition(AnyTransition.offset(randomLocationOffScreen(for: playgroundGeometry.size)))
                                    }
                                }
                                .padding()
                                .frame(height: playgroundGeometry.size.height, alignment: .top)
                                .foregroundColor(.blue)
                                .onAppear {
                                    dealWithAnimation(numCards: defaultDealNum)
                                }
                                .opacity(gameOver ? 0.05 : 1)
                            }
                        }
                    }
                    .layoutPriority(1)
                    
                    Group {
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
                        .frame(minHeight: screenGeometry.size.height * sectionFactorSmall)

                        
                        GeometryReader { bottomBarGeometry in
                            ZStack {
                                Rectangle()
                                    .fill(sectionColor)
                                    .opacity(sectionOpacity)
                                
                                HStack {
                                    GameButton(text: "New Game", action: newGame, height: bottomBarGeometry.size.height)
                                    
                                    GameButton(text: "Deal 3", action: deal3Cards, height: bottomBarGeometry.size.height)
                                        .disabled(setGame.cards.count == 0)
                                        .opacity(setGame.cards.count == 0 ? 0.5 : 1)
                                    
                                    GameButton(text: "Cheat", action: setGame.cheat, height: bottomBarGeometry.size.height)
                                }
                                .padding()
                            }
                        }
                        .padding(.vertical, 0)
                        .frame(minHeight: screenGeometry.size.height * sectionFactor)
                    }
                    .opacity(gameOver ? 0.05 : 1)
                }
            }
        }
    }
    
    private func newGame() {
        withAnimation {
            setGame.newGame()
        }
        dealWithAnimation(numCards: defaultDealNum)
        gameOver = false
    }
    
    private func deal3Cards() {
        setGame.dealCardsPenalty()
        dealWithAnimation(numCards: 3)
    }
    
    @ViewBuilder
    func GameButton(text: String, action: @escaping () -> Void, height: CGFloat) -> some View {
        Button(action:
            action
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .stroke(buttonStrokeColor, lineWidth: buttonStrokeWeight)
                    .frame(height: height * 0.7)


                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .fill(buttonColor)
                    .opacity(buttonOpacity)
                    .frame(height: height * 0.7)


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
        let minColumns = 3
        let defaultPadding: CGFloat = 15
        let defaultCardPaddingFactor: CGFloat = 7/8
        
        let height = size.height - (defaultPadding * 2)
        let width = size.width - (defaultPadding * 2)
        let area = height * width
        let cardArea = area/CGFloat(setGame.cardsInPlay.count) * (defaultCardPaddingFactor)
        let cardWidth = sqrt((3/2) * cardArea)
        var columns = Int(ceil(width / cardWidth))
        columns = columns < minColumns ? minColumns : columns
        return Array(repeating: GridItem(.flexible()), count: columns)
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
    private let backgroundOpacity = 0.3
    
    private let sectionColor = Color.blue
    private let sectionOpacity = 0.1
    
    private let playgroundColor = Color.blue
    private let playgroundOpacity = 0.1
    
    private let sectionFactor: CGFloat = 1/10
    private let sectionFactorSmall: CGFloat = 1/18
    private let playgroundFactor: CGFloat = 1/2
    private let paddingFactorLarge: CGFloat = 1/100
    private let spacingFactor: CGFloat = 1/75
    private let spacingBottomFactor: CGFloat = 1/25000
    
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameVM())
//            .previewLayout(PreviewLayout.fixed(width: 820, height: 414))
    }
}
