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
                        getShapeView()
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
    
    func getShapeView() -> some ShapeView {
        switch card.shape {
        case ShapeProp.oval:
            return ShapeView<OvalShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
        case ShapeProp.diamond:
            return ShapeView<DiamondShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
        case ShapeProp.squiggle:
            return ShapeView<SquiggleShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
        }
    }
    
    func getShape<T: Shape>() -> T {
        switch card.shape {
        case ShapeProp.oval:
            return OvalShape() as! T
        case ShapeProp.diamond:
            return DiamondShape() as! T
        case ShapeProp.squiggle:
            return SquiggleShape() as! T
        }
    }
//
//    func getShapeType<T: Shape>() -> T.Type {
//        switch card.shape {
//        case ShapeProp.oval:
//            return OvalShape.self as! T.Type
//        case ShapeProp.diamond:
//            return DiamondShape.self as! T.Type
//        case ShapeProp.squiggle:
//            return SquiggleShape.self as! T.Type
//        }
//    }
    
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
