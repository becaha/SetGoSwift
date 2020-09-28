//
//  CardContent.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/18/20.
//

import SwiftUI

struct CardContent: View {
    let geometry: GeometryProxy
    let card: Card
    
    
    var body: some View {
        
        VStack {
            Text("\(card.color.rawValue) \(card.shape.rawValue) \(card.pattern.rawValue) \(card.number)")
            GeometryReader { geometry in
                HStack {
                    ForEach(0..<(card.number + 1)) { _ in
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
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .padding(.horizontal, 10)
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
            return 0.3
        case PatternProp.blank:
            return 0
        }
    }
    
    func getArray<Element>() -> Array<Element> {
        return Array<Element>()
    }
    
//    func getShapeView() -> some View {
//        switch card.shape {
//        case ShapeProp.oval:
//            return ShapeView<OvalShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
//        case ShapeProp.diamond:
//            return ShapeView<DiamondShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
//        case ShapeProp.squiggle:
//            return ShapeView<SquiggleShape>(color: getColor(), opacity: getOpacity(), shape: getShape())
//        }
//    }
    
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
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                
                RoundedRectangle(cornerRadius: 10.0).stroke(Color.blue, lineWidth: 3)

                CardContent(geometry: geometry, card: Card(color: 1, shape: 0, pattern: 0, number: 1))
            }
            .aspectRatio(3/2, contentMode: .fit)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .padding()
    }
    
}
