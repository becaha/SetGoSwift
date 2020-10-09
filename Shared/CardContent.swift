//
//  CardContent.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardContent: View {
    let card: Card
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                HStack {
                    ForEach(0..<(card.number + 1), id: \.self) { _ in
                        switch card.shape {
                        case ShapeProp.oval:
                            ShapeView<OvalShape>(width: geometry.size.width, color: getColor(), opacity: getOpacity(), shape: getShape())
                        case ShapeProp.diamond:
                            ShapeView<DiamondShape>(width: geometry.size.width, color: getColor(), opacity: getOpacity(), shape: getShape())
                        case ShapeProp.squiggle:
                            ShapeView<SquiggleShape>(width: geometry.size.width, color: getColor(), opacity: getOpacity(), shape: getShape())
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func getColor() -> Color {
        switch card.color {
        case ColorProp.red:
            return Color.red
        case ColorProp.green:
            return Color.green
        case ColorProp.purple:
            return Color.purple
        }
    }
    
    private func getOpacity() -> Double {
        switch card.pattern {
        case PatternProp.solid:
            return 1.0
        case PatternProp.transparent:
            return 0.3
        case PatternProp.blank:
            return 0
        }
    }
    
    private func getShape<T: Shape>() -> T {
        switch card.shape {
        case ShapeProp.oval:
            return OvalShape() as! T
        case ShapeProp.diamond:
            return DiamondShape() as! T
        case ShapeProp.squiggle:
            return SquiggleShape() as! T
        }
    }
}

struct CardContent_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                
                RoundedRectangle(cornerRadius: 10.0).stroke(Color.blue, lineWidth: 3)

                CardContent(card: Card(color: 1, shape: 0, pattern: 0, number: 1))
            }
            .aspectRatio(3/2, contentMode: .fit)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .padding()
    }
    
}
