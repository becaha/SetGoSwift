//
//  ShapeView.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/25/20.
//

import SwiftUI

struct ShapeView<T: Shape>: View {
    let color: Color
    let opacity: Double
    let shape: T
    
    var body: some View {
        ZStack {
            shape.opacity(opacity)
            shape.stroke(lineWidth: 4)
        }
        .foregroundColor(color)
//        .aspectRatio(contentMode: .fit)
//        .padding(100)
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ShapeView(color: Color.red, opacity: 1.0, shape: DiamondShape())
                .frame(width: geometry.size.width / 3, height: geometry.size.height)
        }
    }
}
