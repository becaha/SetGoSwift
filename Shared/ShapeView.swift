//
//  ShapeView.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/25/20.
//

import SwiftUI

struct ShapeView<T: Shape>: View {
    let width: CGFloat
    let color: Color
    let opacity: Double
    let shape: T
    
    var body: some View {
        ZStack {
            shape.opacity(opacity)
            shape.stroke(lineWidth: 4)
        }
        .foregroundColor(color)
//        .frame(width: width)
        .aspectRatio(3/2, contentMode: .fit)
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ShapeView(width: 100.0, color: Color.red, opacity: 1.0, shape: SquiggleShape())
        }
    }
}
