//
//  CardContent.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardContent: View {
    let card: Card
    let geometry: GeometryProxy
    
    var body: some View {
//        Text("\(card.shape.rawValue), \(card.color.rawValue), " +
//                "\(card.pattern.rawValue), \(card.number)")
//            .font(systemFont(for: geometry.size))

        VStack {
            GeometryReader {
                geometry in
                VStack {
                    ForEach(0..<card.number) { _ in
                        SquiggleView(color: getColor(), opacity: getOpacity())
                            .padding()
                            .transition(AnyTransition.offset(CGSize(width: 50, height: 50)))
                    }
                }
            }
            
        }
    }
    
    func getColor() -> Color {
        switch card.color {
        case ColorProp.red:
            return Color.red
        case ColorProp.green:
            return Color.green
        case ColorProp.purple:
            return Color.purple
        }
    }
    
    func getOpacity() -> Double {
        switch card.pattern {
        case PatternProp.solid:
            return 1.0
        case PatternProp.transparent:
            return 0.5
        case PatternProp.blank:
            return 0
        }
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: size.width / 4)
    }
}

struct CardContent_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            CardContent(card: Card(color: 0, shape: 0, pattern: 0, number: 0), geometry: geometry)
        }
    }
}
