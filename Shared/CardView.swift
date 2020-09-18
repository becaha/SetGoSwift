//
//  CardView.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
            }
            CardContent(card: card)
        }
        .aspectRatio(3/2, contentMode: .fit)
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: size.width / 4)
    }
    
    // MARK: - Drawing constants
    
    private let cardCornerRadius: CGFloat = 10.0
    private let fontScaleFactor: CGFloat = 0.50
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(color: 0, shape: 0, pattern: 0, number: 0)).padding()
    }
}
